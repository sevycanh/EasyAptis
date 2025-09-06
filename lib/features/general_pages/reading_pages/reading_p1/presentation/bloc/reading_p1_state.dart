import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/entities/reading_p1.dart';

class ReadingP1State extends BaseBlocState {
  final bool isLoading;
  final List<ReadingP1Entity> listQuestion;
  final String error;
  final Map<int, int> selectedAnswers; 
  final Map<int, int?> correctAnswers; 
  final bool submitted;
  final int correctCount;

  ReadingP1State({
    this.isLoading = false,
    this.listQuestion = const [],
    this.error = '',
    this.selectedAnswers = const {},
    this.correctAnswers = const {},
    this.submitted = false,
    this.correctCount = 0,
  });

  @override
  ReadingP1State copyWith({
    bool? isLoading,
    List<ReadingP1Entity>? listQuestion,
    String? error,
    Map<int, int>? selectedAnswers,
    Map<int, int?>? correctAnswers,
    bool? submitted,
    int? correctCount,
  }) {
    return ReadingP1State(
      isLoading: isLoading ?? this.isLoading,
      listQuestion: listQuestion ?? this.listQuestion,
      error: error ?? this.error,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      submitted: submitted ?? this.submitted,
      correctCount: correctCount ?? this.correctCount,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        listQuestion,
        error,
        selectedAnswers,
        correctAnswers,
        submitted,
        correctCount,
      ];
}
