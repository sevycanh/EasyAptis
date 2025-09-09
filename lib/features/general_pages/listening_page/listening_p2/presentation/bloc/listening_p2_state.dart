import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/domain/entities/listening_p2_entity.dart';

class ListeningP2State extends BaseBlocState {
  final bool isLoading;
  final String error;
  final List<ListeningP2Entity> listQuestion;
  final int currentIndex;
  final Map<int, Map<int, int?>> selectedAnswers;
  final Map<int, Map<int, bool?>> checkedAnswers;
  final Set<int> checkedQuestions;
  final Set<int> transcriptVisible;
  final bool isPlaying;

  ListeningP2State({
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
  ListeningP2State copyWith({
    bool? isLoading,
    String? error,
    List<ListeningP2Entity>? listQuestion,
    int? currentIndex,
    Map<int, Map<int, int?>>? selectedAnswers,
    final Set<int>? checkedQuestions,
    Set<int>? transcriptVisible,
    bool? isPlaying,
    Map<int, Map<int, bool?>>? checkedAnswers,
  }) {
    return ListeningP2State(
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
