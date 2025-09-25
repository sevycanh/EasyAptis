// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaking_p1_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeakingP1Model _$SpeakingP1ModelFromJson(Map<String, dynamic> json) =>
    SpeakingP1Model(
      index: (json['index'] as num).toInt(),
      question: json['question'] as String,
      suggest: json['suggest'] as String,
    );

Map<String, dynamic> _$SpeakingP1ModelToJson(SpeakingP1Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'question': instance.question,
      'suggest': instance.suggest,
    };
