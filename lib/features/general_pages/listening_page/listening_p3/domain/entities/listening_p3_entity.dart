class ListeningP3Entity {
  final String index;
  final String audioUrl;
  final String topic;
  final String transcript;
  final List<ListeningP3StatementEntity> statements;

  ListeningP3Entity({
    required this.index,
    required this.audioUrl,
    required this.topic,
    required this.transcript,
    required this.statements,
  });
}

class ListeningP3StatementEntity {
  final int id;
  final String text;

  /// "B" = Both, "M" = Man, "W" = Woman
  final String correctAnswer;

  ListeningP3StatementEntity({
    required this.id,
    required this.text,
    required this.correctAnswer,
  });
}
