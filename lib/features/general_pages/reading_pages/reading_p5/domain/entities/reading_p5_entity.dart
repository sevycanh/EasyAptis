class ReadingP5Entity {
  final int index;
  final String topic;
  final List<ReadingP5HeaderEntity> headers;
  final List<ReadingP5ParagraphEntity> paragraphs;

  const ReadingP5Entity({
    required this.index,
    required this.topic,
    required this.headers,
    required this.paragraphs,
  });
}

class ReadingP5HeaderEntity {
  final int id;
  final String text;

  const ReadingP5HeaderEntity({
    required this.id,
    required this.text,
  });
}

class ReadingP5ParagraphEntity {
  final int id;
  final String content;
  final int correctHeaderId;

  const ReadingP5ParagraphEntity({
    required this.id,
    required this.content,
    required this.correctHeaderId,
  });
}
