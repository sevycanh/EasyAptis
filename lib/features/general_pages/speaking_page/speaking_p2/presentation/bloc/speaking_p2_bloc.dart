import 'dart:async';
import 'dart:io';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/domain/usecases/get_s2_questions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'speaking_p2_event.dart';
import 'speaking_p2_state.dart';

class SpeakingP2Bloc extends BaseBloc<SpeakingP2Event, SpeakingP2State> {
  final GetS2Questions getQuestionSpeakingP2;

  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _beepPlayer = AudioPlayer();

  Timer? _recordingTimer;
  Timer? _recordingLimitTimer;
  StreamSubscription<PlayerState>? _playerSubscription;

  SpeakingP2Bloc({required this.getQuestionSpeakingP2})
    : super(SpeakingP2State()) {
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
    on<JumpToTopic>(_onJumpToTopic);

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

  void _onSeekPlayback(SeekPlayback event, Emitter<SpeakingP2State> emit) {
    _audioPlayer.seek(event.position);
  }

  Future<void> _onStartRecording(
    StartRecording event,
    Emitter<SpeakingP2State> emit,
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

    emit(
      state.copyWith(
        recordingStatus: RecordingStatus.recording,
        recordingDuration: Duration.zero,
      ),
    );

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/speaking_record.m4a';
    await _audioRecorder.start(const RecordConfig(), path: path);

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
    Emitter<SpeakingP2State> emit,
  ) {
    emit(state.copyWith(recordingDuration: event.duration));
  }

  Future<void> _onStopRecording(
    StopRecording event,
    Emitter<SpeakingP2State> emit,
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
    Emitter<SpeakingP2State> emit,
  ) async {
    if (state.recordingPath == null) return;
    emit(state.copyWith(recordingStatus: RecordingStatus.playing));
    await _audioPlayer.play();
  }

  Future<void> _onPausePlayback(
    PausePlayback event,
    Emitter<SpeakingP2State> emit,
  ) async {
    await _audioPlayer.pause();
    await _audioPlayer.seek(Duration.zero);
    emit(state.copyWith(recordingStatus: RecordingStatus.stopped));
  }

  Future<void> _onResetRecording(
    ResetRecording event,
    Emitter<SpeakingP2State> emit,
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
    Emitter<SpeakingP2State> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));
    await Future.delayed(const Duration(seconds: 3));
    final result = await getQuestionSpeakingP2(
      Params(page: event.page, limit: event.limit),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (questions) =>
          emit(state.copyWith(isLoading: false, listQuestion: questions)),
    );
  }

  void _onNextPart(NextPart event, Emitter<SpeakingP2State> emit) {
    if (state.currentIndex < state.listQuestion.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  void _onPreviousPart(PreviousPart event, Emitter<SpeakingP2State> emit) {
    if (state.currentIndex > 0) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    }
  }

  void _onJumpToTopic(JumpToTopic event, Emitter<SpeakingP2State> emit) async {
    final targetIndex = event.index;
    if (targetIndex < 0 || targetIndex >= state.listQuestion.length) return;

    if (await _audioRecorder.isRecording()) {
      await _audioRecorder.stop();
    }

    if (_audioPlayer.playing) {
      await _audioPlayer.stop();
    }

    if (state.recordingPath != null) {
      final file = File(state.recordingPath!);
      if (await file.exists()) {
        await file.delete();
      }
    }

    _recordingTimer?.cancel();
    _recordingLimitTimer?.cancel();

    emit(
      state.copyWith(
        currentIndex: targetIndex,
        recordingStatus: RecordingStatus.initial,
        recordingPath: null,
        recordingDuration: Duration.zero,
        totalDuration: Duration.zero,
        error: "",
      ),
    );
  }
}
