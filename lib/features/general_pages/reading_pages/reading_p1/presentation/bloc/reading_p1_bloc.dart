import 'dart:async';

import 'package:bloc/src/bloc.dart';
import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/entities/option_r1_entity.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/usecases/get_r1_questions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/presentation/bloc/reading_p1_event.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/presentation/bloc/reading_p1_state.dart';

class ReadingP1Bloc extends BaseBloc<ReadingP1Event, ReadingP1State> {
  final GetR1Questions getQuestionReadingP1UseCase;
  ReadingP1Bloc({required this.getQuestionReadingP1UseCase})
    : super(ReadingP1State()) {
    on<GetReadingP1Event>(_getReadingP1);
    on<SelectAnswerEvent>(_selectAnswer);
    on<SubmitAnswersEvent>(_submitAnswers);
    on<ResetAnswersEvent>(_resetAnswers);
  }

  Future<void> _getReadingP1(
    GetReadingP1Event event,
    Emitter<ReadingP1State> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final res = await getQuestionReadingP1UseCase(
      Params(page: event.page, limit: event.limit),
    );
    res.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (questions) {
        // Trộn đáp án cho mỗi câu hỏi
        final shuffledQuestions =
            questions.map((q) {
              final shuffledOptions = List<OptionR1Entity>.from(q.options)
                ..shuffle();
              return q.copyWith(options: shuffledOptions);
            }).toList();

        emit(
          state.copyWith(
            isLoading: false,
            listQuestion: shuffledQuestions,
            error: '',
          ),
        );
      },
    );
  }

  void _selectAnswer(SelectAnswerEvent event, Emitter<ReadingP1State> emit) {
    final updated = Map<int, int>.from(state.selectedAnswers);
    updated[event.questionIndex] = event.optionIndex;
    emit(state.copyWith(selectedAnswers: updated));
  }

  void _submitAnswers(SubmitAnswersEvent event, Emitter<ReadingP1State> emit) {
    int correct = 0;
    for (int i = 0; i < state.listQuestion.length; i++) {
      final selectedIndex = state.selectedAnswers[i];
      if (selectedIndex != null &&
          state.listQuestion[i].options[selectedIndex].isCorrect) {
        correct++;
      }
    }
    emit(state.copyWith(submitted: true, correctCount: correct));
  }

  void _resetAnswers(ResetAnswersEvent event, Emitter<ReadingP1State> emit) {
    emit(state.copyWith(selectedAnswers: {}, submitted: false, correctCount: 0));
  }
}
