// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaking_p4_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeakingP4Model _$SpeakingP4ModelFromJson(Map<String, dynamic> json) =>
    SpeakingP4Model(
      index: (json['index'] as num).toInt(),
      questions: (json['questions'] as List<dynamic>)
          .map(
            (e) => SpeakingP4QuestionModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$SpeakingP4ModelToJson(SpeakingP4Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

SpeakingP4QuestionModel _$SpeakingP4QuestionModelFromJson(
  Map<String, dynamic> json,
) => SpeakingP4QuestionModel(
  id: (json['id'] as num).toInt(),
  question: json['question'] as String,
  suggest: json['suggest'] as String,
);

Map<String, dynamic> _$SpeakingP4QuestionModelToJson(
  SpeakingP4QuestionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'question': instance.question,
  'suggest': instance.suggest,
};
