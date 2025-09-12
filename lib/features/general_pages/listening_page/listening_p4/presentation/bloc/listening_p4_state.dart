import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/domain/entities/listening_p4_entity.dart';

class ListeningP4State extends BaseBlocState {
  final bool isLoading;
  final String error;
  final List<ListeningP4Entity> listQuestion;
  final int currentIndex;
  final Map<String, int?> selectedAnswers; // key = "$audioIndex-$questionId"
  final Map<String, int?> correctAnswers;
  final Set<int> transcriptVisible;
  final bool isPlaying;

  ListeningP4State({
    this.isLoading = false,
    this.error = "",
    this.listQuestion = const [],
    this.currentIndex = 0,
    this.selectedAnswers = const {},
    this.correctAnswers = const {},
    this.transcriptVisible = const {},
    this.isPlaying = false,
  });

  @override
  ListeningP4State copyWith({
    bool? isLoading,
    String? error,
    List<ListeningP4Entity>? listQuestion,
    int? currentIndex,
    Map<String, int?>? selectedAnswers,
    Map<String, int?>? correctAnswers,
    Set<int>? transcriptVisible,
    bool? isPlaying,
  }) {
    return ListeningP4State(
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
    isPlaying,
  ];
}
