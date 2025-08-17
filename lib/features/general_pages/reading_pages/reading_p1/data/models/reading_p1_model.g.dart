// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_p1_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingP1Model _$ReadingP1ModelFromJson(Map<String, dynamic> json) =>
    ReadingP1Model(
      index: (json['index'] as num).toInt(),
      questionText: json['questionText'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionR1Model.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReadingP1ModelToJson(ReadingP1Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'questionText': instance.questionText,
      'options': instance.options.map((e) => e.toJson()).toList(),
    };
