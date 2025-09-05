// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_p4_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingP4Model _$ReadingP4ModelFromJson(Map<String, dynamic> json) =>
    ReadingP4Model(
      index: (json['index'] as num).toInt(),
      topic: json['topic'] as String,
      speakers: (json['speakers'] as List<dynamic>)
          .map((e) => SpeakerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReadingP4ModelToJson(ReadingP4Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'topic': instance.topic,
      'speakers': instance.speakers.map((e) => e.toJson()).toList(),
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

SpeakerModel _$SpeakerModelFromJson(Map<String, dynamic> json) =>
    SpeakerModel(id: json['id'] as String, text: json['text'] as String);

Map<String, dynamic> _$SpeakerModelToJson(SpeakerModel instance) =>
    <String, dynamic>{'id': instance.id, 'text': instance.text};

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: (json['id'] as num).toInt(),
      question: json['question'] as String,
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
    };
