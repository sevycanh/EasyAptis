import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/speaking_p4_entity.dart';

part 'speaking_p4_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SpeakingP4Model {
  final int index;
  final List<SpeakingP4QuestionModel> questions;

  SpeakingP4Model({
    required this.index,
    required this.questions,
  });

  factory SpeakingP4Model.fromJson(Map<String, dynamic> json) =>
      _$SpeakingP4ModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakingP4ModelToJson(this);

  SpeakingP4Entity toEntity() => SpeakingP4Entity(
        index: index,
        questions: questions.map((q) => q.toEntity()).toList(),
      );
}

@JsonSerializable()
class SpeakingP4QuestionModel {
  final int id;
  final String question;
  final String suggest;

  SpeakingP4QuestionModel({
    required this.id,
    required this.question,
    required this.suggest,
  });

  factory SpeakingP4QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakingP4QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakingP4QuestionModelToJson(this);

  SpeakingP4QuestionEntity toEntity() => SpeakingP4QuestionEntity(
        id: id,
        question: question,
        suggest: suggest,
      );
}
