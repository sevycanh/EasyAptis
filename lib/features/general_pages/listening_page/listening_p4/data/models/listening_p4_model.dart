import 'package:easyaptis/features/general_pages/listening_page/listening_p4/domain/entities/listening_p4_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listening_p4_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ListeningP4Model {
  final String index;

  @JsonKey(name: "audio_url")
  final String audioUrl;

  final String topic;
  final String transcript;
  final List<ListeningP4QuestionModel> questions;

  ListeningP4Model({
    required this.index,
    required this.audioUrl,
    required this.topic,
    required this.transcript,
    required this.questions,
  });

  factory ListeningP4Model.fromJson(Map<String, dynamic> json) =>
      _$ListeningP4ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningP4ModelToJson(this);

  ListeningP4Entity toEntity() => ListeningP4Entity(
        index: index,
        audioUrl: audioUrl,
        topic: topic,
        transcript: transcript,
        questions: questions.map((q) => q.toEntity()).toList(),
      );
}

@JsonSerializable(explicitToJson: true)
class ListeningP4QuestionModel {
  final int id;
  final String text;
  final List<ListeningP4OptionModel> options;

  ListeningP4QuestionModel({
    required this.id,
    required this.text,
    required this.options,
  });

  factory ListeningP4QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$ListeningP4QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningP4QuestionModelToJson(this);

  ListeningP4QuestionEntity toEntity() => ListeningP4QuestionEntity(
        id: id,
        text: text,
        options: options.map((o) => o.toEntity()).toList(),
      );
}

@JsonSerializable()
class ListeningP4OptionModel {
  final String text;
  final bool isCorrect;

  ListeningP4OptionModel({
    required this.text,
    required this.isCorrect,
  });

  factory ListeningP4OptionModel.fromJson(Map<String, dynamic> json) =>
      _$ListeningP4OptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningP4OptionModelToJson(this);

  ListeningP4OptionEntity toEntity() => ListeningP4OptionEntity(
        text: text,
        isCorrect: isCorrect,
      );
}
