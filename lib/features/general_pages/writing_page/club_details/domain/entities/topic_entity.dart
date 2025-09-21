class TopicEntity {
  final int id;
  final String name;
  final String description;
  final Map<String, PartEntity> parts;

  TopicEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.parts,
  });
}

class PartEntity {
  final String? announcement;
  final List<QuestionEntity> questions;

  PartEntity({this.announcement, required this.questions});
}

class QuestionEntity {
  final int id;
  final String text;

  QuestionEntity({required this.id, required this.text});
}
