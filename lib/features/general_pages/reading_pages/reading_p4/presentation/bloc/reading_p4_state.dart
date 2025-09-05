import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/entities/reading_p4_entity.dart';

class ReadingP4State extends BaseBlocState {
  final bool isLoading;
  final String error;
  final List<ReadingP4Entity> listQuestion;
  final int currentIndex;
  final Map<int, Map<int, String?>> selectedAnswers;
  final Map<int, Map<int, bool>> checkResults;

  ReadingP4State({
    this.isLoading = false,
    this.error = "",
    this.listQuestion = const [],
    this.currentIndex = 0,
    this.selectedAnswers = const {},
    this.checkResults = const {},
  });

  @override
  ReadingP4State copyWith({
    bool? isLoading,
    String? error,
    List<ReadingP4Entity>? listQuestion,
    int? currentIndex,
    Map<int, Map<int, String?>>? selectedAnswers,
    Map<int, Map<int, bool>>? checkResults,
  }) {
    return ReadingP4State(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      listQuestion: listQuestion ?? this.listQuestion,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      checkResults: checkResults ?? this.checkResults
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    error,
    listQuestion,
    currentIndex,
    selectedAnswers,
    checkResults
  ];
}
