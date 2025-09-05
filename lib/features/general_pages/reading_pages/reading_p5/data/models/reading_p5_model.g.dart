// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_p5_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingP5Model _$ReadingP5ModelFromJson(Map<String, dynamic> json) =>
    ReadingP5Model(
      index: (json['index'] as num).toInt(),
      topic: json['topic'] as String,
      headers: (json['headers'] as List<dynamic>)
          .map((e) => ReadingP5HeaderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paragraphs: (json['paragraphs'] as List<dynamic>)
          .map(
            (e) => ReadingP5ParagraphModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$ReadingP5ModelToJson(ReadingP5Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'topic': instance.topic,
      'headers': instance.headers.map((e) => e.toJson()).toList(),
      'paragraphs': instance.paragraphs.map((e) => e.toJson()).toList(),
    };

ReadingP5HeaderModel _$ReadingP5HeaderModelFromJson(
  Map<String, dynamic> json,
) => ReadingP5HeaderModel(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
);

Map<String, dynamic> _$ReadingP5HeaderModelToJson(
  ReadingP5HeaderModel instance,
) => <String, dynamic>{'id': instance.id, 'text': instance.text};

ReadingP5ParagraphModel _$ReadingP5ParagraphModelFromJson(
  Map<String, dynamic> json,
) => ReadingP5ParagraphModel(
  id: (json['id'] as num).toInt(),
  content: json['content'] as String,
  correctHeaderId: (json['correctHeaderId'] as num).toInt(),
);

Map<String, dynamic> _$ReadingP5ParagraphModelToJson(
  ReadingP5ParagraphModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'correctHeaderId': instance.correctHeaderId,
};
