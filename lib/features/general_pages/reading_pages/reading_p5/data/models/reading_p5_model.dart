import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/entities/reading_p5_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reading_p5_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReadingP5Model {
  final int index;
  final String topic;
  final List<ReadingP5HeaderModel> headers;
  final List<ReadingP5ParagraphModel> paragraphs;

  ReadingP5Model({
    required this.index,
    required this.topic,
    required this.headers,
    required this.paragraphs,
  });

  factory ReadingP5Model.fromJson(Map<String, dynamic> json) =>
      _$ReadingP5ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingP5ModelToJson(this);

  ReadingP5Entity toEntity() => ReadingP5Entity(
        index: index,
        topic: topic,
        headers: headers.map((h) => h.toEntity()).toList(),
        paragraphs: paragraphs.map((p) => p.toEntity()).toList(),
      );
}

@JsonSerializable()
class ReadingP5HeaderModel {
  final int id;
  final String text;

  ReadingP5HeaderModel({
    required this.id,
    required this.text,
  });

  factory ReadingP5HeaderModel.fromJson(Map<String, dynamic> json) =>
      _$ReadingP5HeaderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingP5HeaderModelToJson(this);

  ReadingP5HeaderEntity toEntity() => ReadingP5HeaderEntity(
        id: id,
        text: text,
      );
}

@JsonSerializable()
class ReadingP5ParagraphModel {
  final int id;
  final String content;
  final int correctHeaderId;

  ReadingP5ParagraphModel({
    required this.id,
    required this.content,
    required this.correctHeaderId,
  });

  factory ReadingP5ParagraphModel.fromJson(Map<String, dynamic> json) =>
      _$ReadingP5ParagraphModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingP5ParagraphModelToJson(this);

  ReadingP5ParagraphEntity toEntity() => ReadingP5ParagraphEntity(
        id: id,
        content: content,
        correctHeaderId: correctHeaderId,
      );
}
