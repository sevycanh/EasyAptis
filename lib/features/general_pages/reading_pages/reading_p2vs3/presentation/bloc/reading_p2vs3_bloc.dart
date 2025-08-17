import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/entities/reading_p2vs3_entity.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/usecases/get_r23_questions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_event.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingP2vs3Bloc extends BaseBloc<ReadingP2vs3Event, ReadingP2vs3State> {
  final GetR23Questions getQuestionReadingP23UseCase;
  ReadingP2vs3Bloc({required this.getQuestionReadingP23UseCase})
    : super(ReadingP2vs3State()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<ReorderOption>(_onReorderOption);
    on<CheckAnswer>(_onCheckAnswer);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
  }
  Future<void> _onLoadQuestions(
    LoadQuestions event,
    Emitter<ReadingP2vs3State> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getQuestionReadingP23UseCase(
      Params(page: event.page, limit: event.limit),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (questions) {
        if (questions.isEmpty) {
          emit(state.copyWith(isLoading: false, listQuestion: []));
          return;
        }

        final first = questions.first;

        final Map<int, List<OptionR2vs3Entity>> initialOrdersMap = {};
        final List<OptionR2vs3Entity> firstOrder = List.from(first.options)
          ..shuffle();
        initialOrdersMap[0] = firstOrder;

        emit(
          state.copyWith(
            isLoading: false,
            listQuestion: questions,
            currentIndex: 0,
            currentOrder: firstOrder,
            ordersMap: initialOrdersMap,
          ),
        );
      },
    );
  }

  void _onReorderOption(ReorderOption event, Emitter<ReadingP2vs3State> emit) {
    final current = List.of(state.currentOrder);
    final item = current.removeAt(event.oldIndex);
    current.insert(
      event.newIndex > event.oldIndex ? event.newIndex - 1 : event.newIndex,
      item,
    );

    final updatedOrdersMap = Map<int, List<OptionR2vs3Entity>>.from(
      state.ordersMap,
    );
    updatedOrdersMap[state.currentIndex] = List.from(current);

    emit(state.copyWith(currentOrder: current, ordersMap: updatedOrdersMap));
  }

  void _onCheckAnswer(CheckAnswer event, Emitter<ReadingP2vs3State> emit) {
    final currentQ = state.listQuestion[state.currentIndex];

    final Map<String, bool> statusById = {};

    for (int i = 0; i < currentQ.options.length; i++) {
      final option = state.currentOrder[i];
      statusById[option.id.toString()] = option.id == currentQ.options[i].id;
    }

    final updatedMap = Map<int, Map<String, bool>>.from(state.answersStatusMap);
    updatedMap[state.currentIndex] = statusById;

    emit(state.copyWith(answersStatusMap: updatedMap));
  }

  void _onNextQuestion(NextQuestion event, Emitter<ReadingP2vs3State> emit) {
    if (state.currentIndex < state.listQuestion.length - 1) {
      final nextIndex = state.currentIndex + 1;
      final nextQ = state.listQuestion[nextIndex];

      final updatedOrdersMap = Map<int, List<OptionR2vs3Entity>>.from(
        state.ordersMap,
      );

      final nextOrder =
          updatedOrdersMap[nextIndex] ??
          (updatedOrdersMap[nextIndex] = List.from(nextQ.options)..shuffle());

      emit(
        state.copyWith(
          currentIndex: nextIndex,
          currentOrder: List.from(nextOrder),
          ordersMap: updatedOrdersMap,
        ),
      );
    }
  }

  void _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<ReadingP2vs3State> emit,
  ) {
    if (state.currentIndex > 0) {
      final prevIndex = state.currentIndex - 1;
      final prevQ = state.listQuestion[prevIndex];

      final updatedOrdersMap = Map<int, List<OptionR2vs3Entity>>.from(
        state.ordersMap,
      );

      final prevOrder =
          updatedOrdersMap[prevIndex] ??
          (updatedOrdersMap[prevIndex] = List.from(prevQ.options)..shuffle());

      emit(
        state.copyWith(
          currentIndex: prevIndex,
          currentOrder: List.from(prevOrder),
          ordersMap: updatedOrdersMap,
        ),
      );
    }
  }
}
