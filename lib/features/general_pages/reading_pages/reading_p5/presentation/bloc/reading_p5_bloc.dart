import 'dart:async';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/entities/reading_p5_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/usecases/get_r5_questions.dart';
import 'reading_p5_event.dart';
import 'reading_p5_state.dart';

class ReadingP5Bloc extends BaseBloc<ReadingP5Event, ReadingP5State> {
  final GetR5Questions getQuestionReadingP5;

  ReadingP5Bloc({required this.getQuestionReadingP5})
    : super(ReadingP5State()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<AnswerSelected>(_onAnswerSelected);
    on<CheckAnswer>(_onCheckAnswer);
    on<JumpToTopic>(_onJumpToTopic);
  }

  Future<void> _onLoadQuestions(
    LoadQuestions event,
    Emitter<ReadingP5State> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));
    await Future.delayed(const Duration(seconds: 3));
    final result = await getQuestionReadingP5(
      Params(page: event.page, limit: event.limit),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (questions) {
        final Map<int, Map<int, int?>> initSelected = {};
        final Map<int, Map<int, bool>> initChecks = {};
        for (int i = 0; i < questions.length; i++) {
          initSelected[i] = {};
          initChecks[i] = {};
        }

        final shuffledQuestions = questions.map((q) {
          final shuffledHeaders = [...q.headers]..shuffle();
          return ReadingP5Entity(
            index: q.index,
            topic: q.topic,
            headers: shuffledHeaders,
            paragraphs: q.paragraphs,
          );
        }).toList();

        emit(
          state.copyWith(
            isLoading: false,
            listQuestion: shuffledQuestions,
            currentIndex: 0,
            selectedAnswers: initSelected,
            checkResults: initChecks,
          ),
        );
      },
    );
  }

  void _onNextQuestion(NextQuestion event, Emitter<ReadingP5State> emit) {
    if (state.currentIndex < state.listQuestion.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  void _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<ReadingP5State> emit,
  ) {
    if (state.currentIndex > 0) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    }
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<ReadingP5State> emit) {
    final currentIndex = state.currentIndex;
    final newSelected = Map<int, Map<int, int?>>.from(state.selectedAnswers);
    final currentMap = Map<int, int?>.from(newSelected[currentIndex] ?? {});

    currentMap[event.paragraphId] = event.selectedHeaderId;
    newSelected[currentIndex] = currentMap;

    emit(state.copyWith(selectedAnswers: newSelected));
  }

  void _onCheckAnswer(CheckAnswer event, Emitter<ReadingP5State> emit) {
    final currentIndex = state.currentIndex;
    final currentTopic = state.listQuestion[currentIndex];
    final currentSelected = state.selectedAnswers[currentIndex] ?? {};

    final Map<int, bool> resultForTopic = {};

    for (final paragraph in currentTopic.paragraphs) {
      final selectedHeader = currentSelected[paragraph.id];
      resultForTopic[paragraph.id] =
          (selectedHeader != null &&
          selectedHeader == paragraph.correctHeaderId);
    }

    final newChecks = Map<int, Map<int, bool>>.from(state.checkResults);
    newChecks[currentIndex] = resultForTopic;

    emit(state.copyWith(checkResults: newChecks));
  }

  void _onJumpToTopic(JumpToTopic event, Emitter<ReadingP5State> emit) {
    final index = event.index;
    if (index < 0 || index >= state.listQuestion.length) {
      return;
    }
    emit(state.copyWith(currentIndex: index));
  }
}
