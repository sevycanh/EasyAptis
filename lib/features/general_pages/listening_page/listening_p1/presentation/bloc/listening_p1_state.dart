import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/entities/listening_p1_entity.dart';

class ListeningP1State extends BaseBlocState {
  final bool isLoading;
  final String error;
  final List<ListeningP1Entity> listQuestion;
  final int currentIndex;
  final Map<int, int?> selectedAnswers;
  final Map<int, int?> correctAnswers; 
  final Set<int> transcriptVisible;
  final bool isPlaying;

  ListeningP1State({
    this.isLoading = false,
    this.error = "",
    this.listQuestion = const [],
    this.currentIndex = 0,
    this.selectedAnswers = const {},
    this.correctAnswers = const {},
    this.transcriptVisible = const {},
    this.isPlaying = false
  });

  @override
  ListeningP1State copyWith({
    bool? isLoading,
    String? error,
    List<ListeningP1Entity>? listQuestion,
    int? currentIndex,
    Map<int, int?>? selectedAnswers,
    Map<int, int?>? correctAnswers,
    Set<int>? transcriptVisible,
    bool? isPlaying
  }) {
    return ListeningP1State(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      listQuestion: listQuestion ?? this.listQuestion,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      transcriptVisible: transcriptVisible ?? this.transcriptVisible,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    error,
    listQuestion,
    currentIndex,
    selectedAnswers,
    correctAnswers,
    transcriptVisible,
    isPlaying
  ];
}
