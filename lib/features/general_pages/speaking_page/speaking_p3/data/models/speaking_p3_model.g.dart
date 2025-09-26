// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaking_p3_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeakingP3Model _$SpeakingP3ModelFromJson(Map<String, dynamic> json) =>
    SpeakingP3Model(
      index: (json['index'] as num).toInt(),
      image: (json['image'] as List<dynamic>).map((e) => e as String).toList(),
      questions: (json['questions'] as List<dynamic>)
          .map(
            (e) => SpeakingP3QuestionModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$SpeakingP3ModelToJson(SpeakingP3Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'image': instance.image,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

SpeakingP3QuestionModel _$SpeakingP3QuestionModelFromJson(
  Map<String, dynamic> json,
) => SpeakingP3QuestionModel(
  question: json['question'] as String,
  suggest: json['suggest'] as String,
);

Map<String, dynamic> _$SpeakingP3QuestionModelToJson(
  SpeakingP3QuestionModel instance,
) => <String, dynamic>{
  'question': instance.question,
  'suggest': instance.suggest,
};
