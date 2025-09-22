import 'dart:async';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/usecases/get_l1_questions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'listening_p1_event.dart';
import 'listening_p1_state.dart';

class ListeningP1Bloc extends BaseBloc<ListeningP1Event, ListeningP1State> {
  final GetL1Questions getQuestionListeningP1;
  final AudioPlayer _player = AudioPlayer();
  late final StreamSubscription<PlayerState> _playerSubscription;

  ListeningP1Bloc({required this.getQuestionListeningP1})
    : super(ListeningP1State()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<CheckAnswer>(_onCheckAnswer);
    on<AnswerSelected>(_onAnswerSelected);
    on<ToggleTranscript>(_onToggleTranscript);
    on<ToggleAudio>(_onToggleAudio);
    on<AudioCompleted>(_onAudioCompleted);

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
    Emitter<ListeningP1State> emit,
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

  void _onAudioCompleted(AudioCompleted event, Emitter<ListeningP1State> emit) {
    emit(state.copyWith(isPlaying: false));
  }

  Future<void> _onLoadQuestions(
    LoadQuestions event,
    Emitter<ListeningP1State> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));

    final result = await getQuestionListeningP1(
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
    Emitter<ListeningP1State> emit,
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
    Emitter<ListeningP1State> emit,
  ) async {
    if (state.currentIndex > 0) {
      await _player.stop(); // stop audio khi về câu trước
      emit(
        state.copyWith(currentIndex: state.currentIndex - 1, isPlaying: false),
      );
    }
  }

  void _onCheckAnswer(CheckAnswer event, Emitter<ListeningP1State> emit) {
  final current = state.currentIndex;
  final entity = state.listQuestion[current];

  // Tìm đáp án đúng
  final correctIndex = entity.options.indexWhere((opt) => opt.isCorrect);

  final newCorrectAnswers = Map<int, int?>.from(state.correctAnswers);
  newCorrectAnswers[current] = correctIndex;

  emit(state.copyWith(correctAnswers: newCorrectAnswers));
}


  void _onAnswerSelected(AnswerSelected event, Emitter<ListeningP1State> emit) {
    final newSelected = Map<int, int?>.from(state.selectedAnswers);
    newSelected[event.questionIndex] = event.optionIndex;
    emit(state.copyWith(selectedAnswers: newSelected));
  }

  void _onToggleTranscript(
    ToggleTranscript event,
    Emitter<ListeningP1State> emit,
  ) {
    final newSet = Set<int>.from(state.transcriptVisible);
    if (newSet.contains(event.questionIndex)) {
      newSet.remove(event.questionIndex);
    } else {
      newSet.add(event.questionIndex);
    }
    emit(state.copyWith(transcriptVisible: newSet));
  }
}
