import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/entities/listening_p3_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listening_p3_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ListeningP3Model {
  final String index;
  @JsonKey(name: 'audio_url')
  final String audioUrl;
  final String topic;
  final String transcript;
  final List<ListeningP3StatementModel> statements;

  ListeningP3Model({
    required this.index,
    required this.audioUrl,
    required this.topic,
    required this.transcript,
    required this.statements,
  });

  factory ListeningP3Model.fromJson(Map<String, dynamic> json) =>
      _$ListeningP3ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningP3ModelToJson(this);

  ListeningP3Entity toEntity() {
    return ListeningP3Entity(
      index: index,
      audioUrl: audioUrl,
      topic: topic,
      transcript: transcript,
      statements: statements.map((s) => s.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class ListeningP3StatementModel {
  final int id;
  final String text;
  final String correctAnswer;

  ListeningP3StatementModel({
    required this.id,
    required this.text,
    required this.correctAnswer,
  });

  factory ListeningP3StatementModel.fromJson(Map<String, dynamic> json) =>
      _$ListeningP3StatementModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningP3StatementModelToJson(this);

  ListeningP3StatementEntity toEntity() {
    return ListeningP3StatementEntity(
      id: id,
      text: text,
      correctAnswer: correctAnswer,
    );
  }
}
