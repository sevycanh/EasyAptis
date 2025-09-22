// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  parts: (json['parts'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, PartModel.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'parts': instance.parts.map((k, e) => MapEntry(k, e.toJson())),
    };

PartModel _$PartModelFromJson(Map<String, dynamic> json) => PartModel(
  announcement: json['announcement'] as String?,
  questions: (json['questions'] as List<dynamic>)
      .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PartModelToJson(PartModel instance) => <String, dynamic>{
  'announcement': instance.announcement,
  'questions': instance.questions.map((e) => e.toJson()).toList(),
};

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      suggestion: json['suggest'] as String,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'suggest': instance.suggestion,
    };
