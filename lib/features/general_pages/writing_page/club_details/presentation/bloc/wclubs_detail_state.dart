import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/domain/entities/topic_entity.dart';

class WClubsDetailState extends BaseBlocState {
  final bool isLoading;
  final String error;
  final TopicEntity? topic;
  final int currentPart;
  final Map<int, Map<int, String>> answers; 
  final bool showCopyButtons;

  WClubsDetailState({
    this.isLoading = false,
    this.error = "",
    this.topic,
    this.currentPart = 1,
    Map<int, Map<int, String>>? answers,
    this.showCopyButtons = false
  }) : answers = answers ?? {};

  @override
  WClubsDetailState copyWith({
    bool? isLoading,
    String? error,
    TopicEntity? topic,
    int? currentPart,
    Map<int, Map<int, String>>? answers,
    bool? showCopyButtons
  }) {
    return WClubsDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      topic: topic ?? this.topic,
      currentPart: currentPart ?? this.currentPart,
      answers: answers ?? this.answers,
      showCopyButtons: showCopyButtons ?? this.showCopyButtons
    );
  }

  @override
  List<Object?> get props => [isLoading, error, topic, currentPart, answers, showCopyButtons];
}
