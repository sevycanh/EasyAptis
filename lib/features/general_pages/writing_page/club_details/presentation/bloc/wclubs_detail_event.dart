import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/entities/wclubs_entity.dart';

sealed class WClubsDetailEvent {}

class LoadClubDetails extends WClubsDetailEvent {
  final WClubsEntity entity;
  LoadClubDetails({required this.entity});
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
