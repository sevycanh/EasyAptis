import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/entities/reading_p4_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reading_p4_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReadingP4Model {
  final int index;
  final String topic;
  final List<SpeakerModel> speakers;
  final List<QuestionModel> questions;

  ReadingP4Model({
    required this.index,
    required this.topic,
    required this.speakers,
    required this.questions,
  });

  factory ReadingP4Model.fromJson(Map<String, dynamic> json) =>
      _$ReadingP4ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingP4ModelToJson(this);

  /// Convert Model -> Entity
  ReadingP4Entity toEntity() {
    return ReadingP4Entity(
      index: index,
      topic: topic,
      speakers: speakers.map((e) => e.toEntity()).toList(),
      questions: questions.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class SpeakerModel {
  final String id;
  final String text;

  SpeakerModel({
    required this.id,
    required this.text,
  });

  factory SpeakerModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakerModelToJson(this);

  SpeakerR4Entity toEntity() {
    return SpeakerR4Entity(id: id, text: text);
  }
}

@JsonSerializable()
class QuestionModel {
  final int id;
  final String question;
  final String answer;

  QuestionModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  QuestionR4Entity toEntity() {
    return QuestionR4Entity(id: id, question: question, answer: answer);
  }
}
