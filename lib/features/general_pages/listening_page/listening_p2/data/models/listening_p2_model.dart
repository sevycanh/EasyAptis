import 'package:easyaptis/features/general_pages/listening_page/listening_p2/domain/entities/listening_p2_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listening_p2_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ListeningP2Model {
  final int index;
  final String topic;

  @JsonKey(name: "audio_url")
  final String audioUrl;

  final String transcript;
  final List<ListeningP2OptionModel> options;
  final List<ListeningP2SpeakerModel> speakers;

  ListeningP2Model({
    required this.index,
    required this.topic,
    required this.audioUrl,
    required this.transcript,
    required this.options,
    required this.speakers,
  });

  factory ListeningP2Model.fromJson(Map<String, dynamic> json) =>
      _$ListeningP2ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningP2ModelToJson(this);

  /// Convert Model -> Entity
  ListeningP2Entity toEntity() => ListeningP2Entity(
        index: index,
        topic: topic,
        audioUrl: audioUrl,
        transcript: transcript,
        options: options.map((e) => e.toEntity()).toList(),
        speakers: speakers.map((e) => e.toEntity()).toList(),
      );
}

@JsonSerializable()
class ListeningP2OptionModel {
  final int index;
  final String text;

  ListeningP2OptionModel({
    required this.index,
    required this.text,
  });

  factory ListeningP2OptionModel.fromJson(Map<String, dynamic> json) =>
      _$ListeningP2OptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningP2OptionModelToJson(this);

  ListeningP2OptionEntity toEntity() =>
      ListeningP2OptionEntity(index: index, text: text);
}

@JsonSerializable()
class ListeningP2SpeakerModel {
  final int speaker;

  @JsonKey(name: "correct_option")
  final int correctOption;

  ListeningP2SpeakerModel({
    required this.speaker,
    required this.correctOption,
  });

  factory ListeningP2SpeakerModel.fromJson(Map<String, dynamic> json) =>
      _$ListeningP2SpeakerModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningP2SpeakerModelToJson(this);

  ListeningP2SpeakerEntity toEntity() =>
      ListeningP2SpeakerEntity(speaker: speaker, correctOption: correctOption);
}