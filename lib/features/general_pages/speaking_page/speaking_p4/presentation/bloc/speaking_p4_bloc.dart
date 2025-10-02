import 'dart:async';
import 'dart:io';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/domain/usecases/get_s4_questions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'speaking_p4_event.dart';
import 'speaking_p4_state.dart';

class SpeakingP4Bloc extends BaseBloc<SpeakingP4Event, SpeakingP4State> {
  final GetS4Questions getQuestionSpeakingP4;

  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _beepPlayer = AudioPlayer();

  Timer? _recordingTimer;
  Timer? _recordingLimitTimer;
  StreamSubscription<PlayerState>? _playerSubscription;

  SpeakingP4Bloc({required this.getQuestionSpeakingP4})
    : super(SpeakingP4State()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<StartRecording>(_onStartRecording);
    on<StopRecording>(_onStopRecording);
    on<PlayRecording>(_onPlayRecording);
    on<PausePlayback>(_onPausePlayback);
    on<ResetRecording>(_onResetRecording);
    on<UpdateRecordingTimer>(_onUpdateRecordingTimer);
    on<SeekPlayback>(_onSeekPlayback);

    on<NextPart>(_onNextPart);
    on<PreviousPart>(_onPreviousPart);

    _initPlayers();
  }

  Future<void> _initPlayers() async {
    await _beepPlayer.setAsset('assets/audio/beep.mp3');

    _playerSubscription = _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        _audioPlayer.seek(Duration.zero);
        add(PausePlayback());
      }
    });
  }

  @override
  Future<void> close() {
    _playerSubscription?.cancel();
    _recordingTimer?.cancel();
    _recordingLimitTimer?.cancel();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _beepPlayer.dispose();
    return super.close();
  }

  void _onSeekPlayback(SeekPlayback event, Emitter<SpeakingP4State> emit) {
    _audioPlayer.seek(event.position);
  }

  Future<void> _onStartRecording(
    StartRecording event,
    Emitter<SpeakingP4State> emit,
  ) async {
    final granted = await Permission.microphone.request().isGranted;
    if (!granted) {
      emit(state.copyWith(error: "Vui lòng cấp quyền truy cập micro."));
      return;
    }
    add(ResetRecording());

    await _beepPlayer.seek(Duration.zero);
    await _beepPlayer.play();

    await _beepPlayer.playerStateStream.firstWhere(
      (s) => s.processingState == ProcessingState.completed,
    );

    await Future.delayed(const Duration(milliseconds: 300));

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/speaking_record.m4a';
    await _audioRecorder.start(const RecordConfig(), path: path);

    emit(
      state.copyWith(
        recordingStatus: RecordingStatus.recording,
        recordingDuration: Duration.zero,
      ),
    );

    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(UpdateRecordingTimer(Duration(seconds: timer.tick)));
    });

    _recordingLimitTimer = Timer(
      Duration(seconds: event.timeLimitInSeconds),
      () {
        if (state.recordingStatus == RecordingStatus.recording) {
          add(StopRecording());
        }
      },
    );
  }

  void _onUpdateRecordingTimer(
    UpdateRecordingTimer event,
    Emitter<SpeakingP4State> emit,
  ) {
    emit(state.copyWith(recordingDuration: event.duration));
  }

  Future<void> _onStopRecording(
    StopRecording event,
    Emitter<SpeakingP4State> emit,
  ) async {
    _recordingTimer?.cancel();
    _recordingLimitTimer?.cancel();

    if (!await _audioRecorder.isRecording()) return;

    final path = await _audioRecorder.stop();
    if (path == null || !await File(path).exists()) return;

    await _audioPlayer.stop();
    await Future.delayed(const Duration(milliseconds: 200));

    final duration = await _audioPlayer.setFilePath(path);

    emit(
      state.copyWith(
        recordingStatus: RecordingStatus.stopped,
        recordingPath: path,
        totalDuration: duration ?? Duration.zero,
      ),
    );
  }

  Future<void> _onPlayRecording(
    PlayRecording event,
    Emitter<SpeakingP4State> emit,
  ) async {
    if (state.recordingPath == null) return;
    emit(state.copyWith(recordingStatus: RecordingStatus.playing));
    await _audioPlayer.play();
  }

  Future<void> _onPausePlayback(
    PausePlayback event,
    Emitter<SpeakingP4State> emit,
  ) async {
    await _audioPlayer.pause();
    await _audioPlayer.seek(Duration.zero);
    emit(state.copyWith(recordingStatus: RecordingStatus.stopped));
  }

  Future<void> _onResetRecording(
    ResetRecording event,
    Emitter<SpeakingP4State> emit,
  ) async {
    _recordingTimer?.cancel();
    _recordingLimitTimer?.cancel();

    if (await _audioRecorder.isRecording()) {
      await _audioRecorder.stop();
    }
    await _audioPlayer.stop();

    if (state.recordingPath != null) {
      final file = File(state.recordingPath!);
      if (await file.exists()) {
        await file.delete();
      }
    }

    emit(
      state.copyWith(
        recordingStatus: RecordingStatus.initial,
        recordingPath: null,
        recordingDuration: Duration.zero,
        totalDuration: Duration.zero,
      ),
    );
  }

  Future<void> _onLoadQuestions(
    LoadQuestions event,
    Emitter<SpeakingP4State> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));
    final result = await getQuestionSpeakingP4(
      Params(page: event.page, limit: event.limit),
    );

    await Future.delayed(const Duration(seconds: 3));

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (questions) =>
          emit(state.copyWith(isLoading: false, listQuestion: questions)),
    );
  }

  void _onNextPart(NextPart event, Emitter<SpeakingP4State> emit) {
    if (state.currentIndex < state.listQuestion.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  void _onPreviousPart(PreviousPart event, Emitter<SpeakingP4State> emit) {
    if (state.currentIndex > 0) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    }
  }
}
