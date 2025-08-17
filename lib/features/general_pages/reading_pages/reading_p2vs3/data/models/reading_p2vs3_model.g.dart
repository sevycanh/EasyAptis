// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_p2vs3_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingP2vs3Model _$ReadingP2vs3ModelFromJson(Map<String, dynamic> json) =>
    ReadingP2vs3Model(
      index: (json['index'] as num).toInt(),
      questionText: json['questionText'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionP2vs3Model.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReadingP2vs3ModelToJson(ReadingP2vs3Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'questionText': instance.questionText,
      'options': instance.options.map((e) => e.toJson()).toList(),
    };

OptionP2vs3Model _$OptionP2vs3ModelFromJson(Map<String, dynamic> json) =>
    OptionP2vs3Model(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$OptionP2vs3ModelToJson(OptionP2vs3Model instance) =>
    <String, dynamic>{'id': instance.id, 'text': instance.text};
