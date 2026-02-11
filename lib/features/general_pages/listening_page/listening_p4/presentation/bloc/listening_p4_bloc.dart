import 'dart:async';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/domain/usecases/get_l4_questions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'listening_p4_event.dart';
import 'listening_p4_state.dart';

class ListeningP4Bloc extends BaseBloc<ListeningP4Event, ListeningP4State> {
  final GetL4Questions getQuestionListeningP4;
  final AudioPlayer _player = AudioPlayer();
  late final StreamSubscription<PlayerState> _playerSubscription;

  ListeningP4Bloc({required this.getQuestionListeningP4})
    : super(ListeningP4State()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<CheckAnswer>(_onCheckAnswer);
    on<AnswerSelected>(_onAnswerSelected);
    on<ToggleTranscript>(_onToggleTranscript);
    on<ToggleAudio>(_onToggleAudio);
    on<AudioCompleted>(_onAudioCompleted);
    on<JumpToTopic>(_onJumpToTopic);

    _playerSubscription = _player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        add(AudioCompleted());
      }
    });
  }

  @override
  Future<void> close() {
    _playerSubscription.cancel();
    _player.dispose();
    return super.close();
  }

  Future<void> _onToggleAudio(
    ToggleAudio event,
    Emitter<ListeningP4State> emit,
  ) async {
    if (state.isPlaying) {
      await _player.stop();
      emit(state.copyWith(isPlaying: false));
    } else {
      await _player.stop();
      await _player.setUrl(event.url);
      emit(state.copyWith(isPlaying: true));
      await _player.play();
    }
  }

  void _onAudioCompleted(AudioCompleted event, Emitter<ListeningP4State> emit) {
    emit(state.copyWith(isPlaying: false));
  }

  Future<void> _onLoadQuestions(
    LoadQuestions event,
    Emitter<ListeningP4State> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));
    await Future.delayed(const Duration(seconds: 3));
    final result = await getQuestionListeningP4(
      Params(page: event.page, limit: event.limit),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (questions) {
        emit(
          state.copyWith(
            isLoading: false,
            listQuestion: questions,
            currentIndex: 0,
            selectedAnswers: {},
            correctAnswers: {},
            transcriptVisible: {},
          ),
        );
      },
    );
  }

  void _onNextQuestion(
    NextQuestion event,
    Emitter<ListeningP4State> emit,
  ) async {
    if (state.currentIndex < state.listQuestion.length - 1) {
      await _player.stop(); // stop audio khi qua câu mới
      emit(
        state.copyWith(currentIndex: state.currentIndex + 1, isPlaying: false),
      );
    }
  }

  void _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<ListeningP4State> emit,
  ) async {
    if (state.currentIndex > 0) {
      await _player.stop(); // stop audio khi về câu trước
      emit(
        state.copyWith(currentIndex: state.currentIndex - 1, isPlaying: false),
      );
    }
  }

  void _onCheckAnswer(CheckAnswer event, Emitter<ListeningP4State> emit) {
    final audioIdx = state.currentIndex;
    final entity = state.listQuestion[audioIdx];

    final newCorrectAnswers = Map<String, int?>.from(state.correctAnswers);

    for (var q in entity.questions) {
      final correctIndex = q.options.indexWhere((opt) => opt.isCorrect);
      if (correctIndex != -1) {
        newCorrectAnswers["$audioIdx-${q.id}"] = correctIndex;
      }
    }

    emit(state.copyWith(correctAnswers: newCorrectAnswers));
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<ListeningP4State> emit) {
    final newSelected = Map<String, int?>.from(state.selectedAnswers);
    newSelected["${event.audioIndex}-${event.questionId}"] = event.optionIndex;
    emit(state.copyWith(selectedAnswers: newSelected));
  }

  void _onToggleTranscript(
    ToggleTranscript event,
    Emitter<ListeningP4State> emit,
  ) {
    final newSet = Set<int>.from(state.transcriptVisible);
    if (newSet.contains(event.questionIndex)) {
      newSet.remove(event.questionIndex);
    } else {
      newSet.add(event.questionIndex);
    }
    emit(state.copyWith(transcriptVisible: newSet));
  }

  void _onJumpToTopic(JumpToTopic event, Emitter<ListeningP4State> emit) async {
    final index = event.index;
    if (index < 0 || index >= state.listQuestion.length) return;
    await _player.stop();
    emit(state.copyWith(currentIndex: index, isPlaying: false));
  }
}
