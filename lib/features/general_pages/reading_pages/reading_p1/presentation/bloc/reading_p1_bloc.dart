import 'dart:async';
import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/entities/option_r1_entity.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/usecases/get_r1_questions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reading_p1_event.dart';
import 'reading_p1_state.dart';

class ReadingP1Bloc extends BaseBloc<ReadingP1Event, ReadingP1State> {
  final GetR1Questions getQuestionReadingP1UseCase;

  ReadingP1Bloc({required this.getQuestionReadingP1UseCase})
    : super(ReadingP1State()) {
    on<GetReadingP1Event>(_getReadingP1);
    on<AnswerSelected>(_answerSelected);
    on<CheckAnswersEvent>(_checkAnswers);
    on<LoadMoreQuestionsEvent>((event, emit) {
      final newCount = state.visibleCount + 10;
      emit(
        state.copyWith(
          visibleCount:
              newCount > state.listQuestion.length
                  ? state.listQuestion.length
                  : newCount,
        ),
      );
    });
  }

  Future<void> _getReadingP1(
    GetReadingP1Event event,
    Emitter<ReadingP1State> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final res = await getQuestionReadingP1UseCase(
      Params(page: event.page, limit: event.limit),
    );
    await Future.delayed(const Duration(seconds: 3));
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

        // Lưu index đáp án đúng cho từng câu
        final correctMap = <int, int?>{};
        for (int i = 0; i < shuffledQuestions.length; i++) {
          final correctIndex = shuffledQuestions[i].options.indexWhere(
            (o) => o.isCorrect,
          );
          correctMap[i] = correctIndex != -1 ? correctIndex : null;
        }

        emit(
          state.copyWith(
            isLoading: false,
            listQuestion: shuffledQuestions,
            correctAnswers: correctMap,
            error: '',
          ),
        );
      },
    );
  }

  void _answerSelected(AnswerSelected event, Emitter<ReadingP1State> emit) {
    final updated = Map<int, int>.from(state.selectedAnswers);
    updated[event.questionIndex] = event.optionIndex;
    emit(state.copyWith(selectedAnswers: updated));
  }

  void _checkAnswers(CheckAnswersEvent event, Emitter<ReadingP1State> emit) {
    int correct = 0;
    for (int i = 0; i < state.listQuestion.length; i++) {
      final selectedIndex = state.selectedAnswers[i];
      final correctIndex = state.correctAnswers[i];
      if (selectedIndex != null && selectedIndex == correctIndex) {
        correct++;
      }
    }
    emit(state.copyWith(submitted: true, correctCount: correct));
  }
}
