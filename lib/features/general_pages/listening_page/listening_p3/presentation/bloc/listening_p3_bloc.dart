import 'dart:async';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/usecases/get_l3_questions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'listening_p3_event.dart';
import 'listening_p3_state.dart';

class ListeningP3Bloc extends BaseBloc<ListeningP3Event, ListeningP3State> {
  final GetL3Questions getQuestionListeningP3;
  final AudioPlayer _player = AudioPlayer();
  late final StreamSubscription<PlayerState> _playerSubscription;

  ListeningP3Bloc({required this.getQuestionListeningP3})
      : super(ListeningP3State()) {
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
    Emitter<ListeningP3State> emit,
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

  void _onAudioCompleted(AudioCompleted event, Emitter<ListeningP3State> emit) {
    emit(state.copyWith(isPlaying: false));
  }

  Future<void> _onLoadQuestions(
    LoadQuestions event,
    Emitter<ListeningP3State> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));

    final result = await getQuestionListeningP3(
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
            transcriptVisible: {},
            checkedAnswers: {},
          ),
        );
      },
    );
  }

  void _onNextQuestion(
    NextQuestion event,
    Emitter<ListeningP3State> emit,
  ) async {
    if (state.currentIndex < state.listQuestion.length - 1) {
      await _player.stop();
      emit(
        state.copyWith(currentIndex: state.currentIndex + 1, isPlaying: false),
      );
    }
  }

  void _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<ListeningP3State> emit,
  ) async {
    if (state.currentIndex > 0) {
      await _player.stop();
      emit(
        state.copyWith(currentIndex: state.currentIndex - 1, isPlaying: false),
      );
    }
  }

  void _onCheckAnswer(CheckAnswer event, Emitter<ListeningP3State> emit) {
    final current = state.currentIndex;
    final entity = state.listQuestion[current];

    final selectedForQuestion = state.selectedAnswers[current] ?? {};

    final newCheckedAnswers = Map<int, Map<int, bool?>>.from(
      state.checkedAnswers,
    );

    final statementMap = <int, bool?>{};
    for (var st in entity.statements) {
      final selected = selectedForQuestion[st.id];
      if (selected == null) {
        statementMap[st.id] = null;
      } else if (selected == st.correctAnswer) {
        statementMap[st.id] = true;
      } else {
        statementMap[st.id] = false;
      }
    }

    newCheckedAnswers[current] = statementMap;

    final newCheckedQuestions = Set<int>.from(state.checkedQuestions)
      ..add(current);

    emit(
      state.copyWith(
        checkedAnswers: newCheckedAnswers,
        checkedQuestions: newCheckedQuestions,
      ),
    );
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<ListeningP3State> emit) {
    final newSelected = Map<int, Map<int, String?>>.from(state.selectedAnswers);
    final statementMap = Map<int, String?>.from(
      newSelected[event.questionIndex] ?? {},
    );
    statementMap[event.statementId] = event.answer;
    newSelected[event.questionIndex] = statementMap;
    emit(state.copyWith(selectedAnswers: newSelected));
  }

  void _onToggleTranscript(
    ToggleTranscript event,
    Emitter<ListeningP3State> emit,
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
