// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening_p1_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListeningP1Model _$ListeningP1ModelFromJson(Map<String, dynamic> json) =>
    ListeningP1Model(
      index: (json['index'] as num).toInt(),
      question: json['question'] as String,
      audioUrl: json['audio_url'] as String,
      transcript: json['transcript'] as String,
      options: (json['options'] as List<dynamic>)
          .map(
            (e) => ListeningP1OptionModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$ListeningP1ModelToJson(ListeningP1Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'question': instance.question,
      'audio_url': instance.audioUrl,
      'transcript': instance.transcript,
      'options': instance.options.map((e) => e.toJson()).toList(),
    };

ListeningP1OptionModel _$ListeningP1OptionModelFromJson(
  Map<String, dynamic> json,
) => ListeningP1OptionModel(
  isCorrect: json['isCorrect'] as bool,
  text: json['text'] as String,
);

Map<String, dynamic> _$ListeningP1OptionModelToJson(
  ListeningP1OptionModel instance,
) => <String, dynamic>{'isCorrect': instance.isCorrect, 'text': instance.text};
