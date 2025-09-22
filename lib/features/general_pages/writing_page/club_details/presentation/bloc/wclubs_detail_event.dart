sealed class WClubsDetailEvent {}

class LoadClubDetails extends WClubsDetailEvent {
  final int clubId;
  LoadClubDetails({required this.clubId});
}

class NextPart extends WClubsDetailEvent {}
class PreviousPart extends WClubsDetailEvent {}

class UpdateAnswer extends WClubsDetailEvent {
  final int partId;
  final int questionId;
  final String answer;

  UpdateAnswer({
    required this.partId,
    required this.questionId,
    required this.answer,
  });
}

class ToggleCopyButtons extends WClubsDetailEvent {}
