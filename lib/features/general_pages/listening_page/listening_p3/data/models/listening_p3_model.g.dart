// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening_p3_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListeningP3Model _$ListeningP3ModelFromJson(Map<String, dynamic> json) =>
    ListeningP3Model(
      index: json['index'] as String,
      audioUrl: json['audio_url'] as String,
      topic: json['topic'] as String,
      transcript: json['transcript'] as String,
      statements: (json['statements'] as List<dynamic>)
          .map(
            (e) =>
                ListeningP3StatementModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$ListeningP3ModelToJson(ListeningP3Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'audio_url': instance.audioUrl,
      'topic': instance.topic,
      'transcript': instance.transcript,
      'statements': instance.statements.map((e) => e.toJson()).toList(),
    };

ListeningP3StatementModel _$ListeningP3StatementModelFromJson(
  Map<String, dynamic> json,
) => ListeningP3StatementModel(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
  correctAnswer: json['correctAnswer'] as String,
);

Map<String, dynamic> _$ListeningP3StatementModelToJson(
  ListeningP3StatementModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'correctAnswer': instance.correctAnswer,
};
