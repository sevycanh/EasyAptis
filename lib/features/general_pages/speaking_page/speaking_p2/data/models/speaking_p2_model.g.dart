// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaking_p2_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeakingP2Model _$SpeakingP2ModelFromJson(Map<String, dynamic> json) =>
    SpeakingP2Model(
      index: (json['index'] as num).toInt(),
      image: json['image'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map(
            (e) => SpeakingP2QuestionModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$SpeakingP2ModelToJson(SpeakingP2Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'image': instance.image,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

SpeakingP2QuestionModel _$SpeakingP2QuestionModelFromJson(
  Map<String, dynamic> json,
) => SpeakingP2QuestionModel(
  question: json['question'] as String,
  suggest: json['suggest'] as String,
);

Map<String, dynamic> _$SpeakingP2QuestionModelToJson(
  SpeakingP2QuestionModel instance,
) => <String, dynamic>{
  'question': instance.question,
  'suggest': instance.suggest,
};
