import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/entities/reading_p5_entity.dart';

class ReadingP5State extends BaseBlocState {
  final bool isLoading;
  final String error;
  final List<ReadingP5Entity> listQuestion;
  final int currentIndex;
  final Map<int, Map<int, int?>> selectedAnswers; 
  final Map<int, Map<int, bool>> checkResults; 

  ReadingP5State({
    this.isLoading = false,
    this.error = "",
    this.listQuestion = const [],
    this.currentIndex = 0,
    this.selectedAnswers = const {},
    this.checkResults = const {},
  });

  @override
  ReadingP5State copyWith({
    bool? isLoading,
    String? error,
    List<ReadingP5Entity>? listQuestion,
    int? currentIndex,
    Map<int, Map<int, int?>>? selectedAnswers,
    Map<int, Map<int, bool>>? checkResults,
  }) {
    return ReadingP5State(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      listQuestion: listQuestion ?? this.listQuestion,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      checkResults: checkResults ?? this.checkResults,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, error, listQuestion, currentIndex, selectedAnswers, checkResults];
}
