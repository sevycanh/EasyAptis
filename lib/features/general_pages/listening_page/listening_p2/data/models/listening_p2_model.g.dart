// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening_p2_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListeningP2Model _$ListeningP2ModelFromJson(
  Map<String, dynamic> json,
) => ListeningP2Model(
  index: (json['index'] as num).toInt(),
  topic: json['topic'] as String,
  audioUrl: json['audio_url'] as String,
  transcript: json['transcript'] as String,
  options: (json['options'] as List<dynamic>)
      .map((e) => ListeningP2OptionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  speakers: (json['speakers'] as List<dynamic>)
      .map((e) => ListeningP2SpeakerModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ListeningP2ModelToJson(ListeningP2Model instance) =>
    <String, dynamic>{
      'index': instance.index,
      'topic': instance.topic,
      'audio_url': instance.audioUrl,
      'transcript': instance.transcript,
      'options': instance.options.map((e) => e.toJson()).toList(),
      'speakers': instance.speakers.map((e) => e.toJson()).toList(),
    };

ListeningP2OptionModel _$ListeningP2OptionModelFromJson(
  Map<String, dynamic> json,
) => ListeningP2OptionModel(
  index: (json['index'] as num).toInt(),
  text: json['text'] as String,
);

Map<String, dynamic> _$ListeningP2OptionModelToJson(
  ListeningP2OptionModel instance,
) => <String, dynamic>{'index': instance.index, 'text': instance.text};

ListeningP2SpeakerModel _$ListeningP2SpeakerModelFromJson(
  Map<String, dynamic> json,
) => ListeningP2SpeakerModel(
  speaker: (json['speaker'] as num).toInt(),
  correctOption: (json['correct_option'] as num).toInt(),
);

Map<String, dynamic> _$ListeningP2SpeakerModelToJson(
  ListeningP2SpeakerModel instance,
) => <String, dynamic>{
  'speaker': instance.speaker,
  'correct_option': instance.correctOption,
};
