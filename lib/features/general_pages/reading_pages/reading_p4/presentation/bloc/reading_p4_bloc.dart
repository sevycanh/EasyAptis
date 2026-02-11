import 'dart:async';

import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/usecases/get_r4_questions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/presentation/bloc/reading_p4_event.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/presentation/bloc/reading_p4_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingP4Bloc extends BaseBloc<ReadingP4Event, ReadingP4State> {
  final GetR4Questions getQuestionReadingP4;

  ReadingP4Bloc({required this.getQuestionReadingP4})
    : super(ReadingP4State()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<CheckAnswer>(_onCheckAnswer);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<AnswerSelected>(_onAnswerSelected);
    on<JumpToTopic>(_onJumpToTopic);
  }

  Future<void> _onLoadQuestions(
    LoadQuestions event,
    Emitter<ReadingP4State> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));
    await Future.delayed(const Duration(seconds: 3));
    final result = await getQuestionReadingP4(
      Params(page: event.page, limit: event.limit),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (questions) {
        final Map<int, Map<int, String?>> initSelected = {};
        final Map<int, Map<int, bool>> initChecks = {};
        for (int i = 0; i < questions.length; i++) {
          initSelected[i] = <int, String?>{};
          initChecks[i] = <int, bool>{};
        }

        emit(
          state.copyWith(
            isLoading: false,
            listQuestion: questions,
            currentIndex: 0,
            selectedAnswers: initSelected,
            checkResults: initChecks,
          ),
        );
      },
    );
  }

  void _onNextQuestion(NextQuestion event, Emitter<ReadingP4State> emit) {
    if (state.currentIndex < state.listQuestion.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  void _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<ReadingP4State> emit,
  ) {
    if (state.currentIndex > 0) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    }
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<ReadingP4State> emit) {
    final currentIndex = state.currentIndex;

    final newSelected = Map<int, Map<int, String?>>.from(state.selectedAnswers);

    final currentMap = Map<int, String?>.from(newSelected[currentIndex] ?? {});

    currentMap[event.questionIndex] = event.selectedSpeaker;

    newSelected[currentIndex] = currentMap;

    emit(state.copyWith(selectedAnswers: newSelected));
  }

  void _onCheckAnswer(CheckAnswer event, Emitter<ReadingP4State> emit) {
    final currentIndex = state.currentIndex;
    final currentTopic = state.listQuestion[currentIndex];

    final Map<int, bool> resultForTopic = {};

    final currentSelected = state.selectedAnswers[currentIndex] ?? {};

    for (final q in currentTopic.questions) {
      final selected = currentSelected[q.id];
      resultForTopic[q.id] = (selected != null && selected == q.answer);
    }

    final newChecks = Map<int, Map<int, bool>>.from(state.checkResults);
    newChecks[currentIndex] = resultForTopic;

    emit(state.copyWith(checkResults: newChecks));
  }

  void _onJumpToTopic(JumpToTopic event, Emitter<ReadingP4State> emit) {
    final index = event.index;
    if (index < 0 || index >= state.listQuestion.length) {
      return;
    }
    emit(state.copyWith(currentIndex: index));
  }
}
