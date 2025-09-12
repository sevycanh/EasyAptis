import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/entities/listening_p3_entity.dart';

class ListeningP3State extends BaseBlocState {
  final bool isLoading;
  final String error;
  final List<ListeningP3Entity> listQuestion;
  final int currentIndex;
  final Map<int, Map<int, String?>> selectedAnswers; // questionIndex -> statementId -> "B/M/W"
  final Map<int, Map<int, bool?>> checkedAnswers;   // questionIndex -> statementId -> đúng/sai
  final Set<int> checkedQuestions;
  final Set<int> transcriptVisible;
  final bool isPlaying;

  ListeningP3State({
    this.isLoading = false,
    this.error = "",
    this.listQuestion = const [],
    this.currentIndex = 0,
    this.selectedAnswers = const {},
    this.checkedQuestions = const {},
    this.transcriptVisible = const {},
    this.isPlaying = false,
    this.checkedAnswers = const {},
  });

  @override
  ListeningP3State copyWith({
    bool? isLoading,
    String? error,
    List<ListeningP3Entity>? listQuestion,
    int? currentIndex,
    Map<int, Map<int, String?>>? selectedAnswers,
    Set<int>? checkedQuestions,
    Set<int>? transcriptVisible,
    bool? isPlaying,
    Map<int, Map<int, bool?>>? checkedAnswers,
  }) {
    return ListeningP3State(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      listQuestion: listQuestion ?? this.listQuestion,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      checkedQuestions: checkedQuestions ?? this.checkedQuestions,
      transcriptVisible: transcriptVisible ?? this.transcriptVisible,
      isPlaying: isPlaying ?? this.isPlaying,
      checkedAnswers: checkedAnswers ?? this.checkedAnswers,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        listQuestion,
        currentIndex,
        selectedAnswers,
        checkedQuestions,
        transcriptVisible,
        isPlaying,
        checkedAnswers
      ];
}
