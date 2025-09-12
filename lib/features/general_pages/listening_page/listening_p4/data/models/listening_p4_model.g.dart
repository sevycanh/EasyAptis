// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening_p4_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListeningP4Model _$ListeningP4ModelFromJson(Map<String, dynamic> json) =>
    ListeningP4Model(
      index: json['index'] as String,
      audioUrl: json['audio_url'] as String,
      topic: json['topic'] as String,
      transcript: json['transcript'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map(
            (e) => ListeningP4QuestionModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$ListeningP4ModelToJson(ListeningP4Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'audio_url': instance.audioUrl,
      'topic': instance.topic,
      'transcript': instance.transcript,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

ListeningP4QuestionModel _$ListeningP4QuestionModelFromJson(
  Map<String, dynamic> json,
) => ListeningP4QuestionModel(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
  options: (json['options'] as List<dynamic>)
      .map((e) => ListeningP4OptionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ListeningP4QuestionModelToJson(
  ListeningP4QuestionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'options': instance.options.map((e) => e.toJson()).toList(),
};

ListeningP4OptionModel _$ListeningP4OptionModelFromJson(
  Map<String, dynamic> json,
) => ListeningP4OptionModel(
  text: json['text'] as String,
  isCorrect: json['isCorrect'] as bool,
);

Map<String, dynamic> _$ListeningP4OptionModelToJson(
  ListeningP4OptionModel instance,
) => <String, dynamic>{'text': instance.text, 'isCorrect': instance.isCorrect};
