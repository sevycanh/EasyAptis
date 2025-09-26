import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/speaking_p2_entity.dart';

part 'speaking_p2_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SpeakingP2Model {
  final int index;
  final String image;
  final List<SpeakingP2QuestionModel> questions;

  SpeakingP2Model({
    required this.index,
    required this.image,
    required this.questions,
  });

  factory SpeakingP2Model.fromJson(Map<String, dynamic> json) =>
      _$SpeakingP2ModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakingP2ModelToJson(this);

  SpeakingP2Entity toEntity() => SpeakingP2Entity(
        index: index,
        image: image,
        questions: questions.map((q) => q.toEntity()).toList(),
      );
}

@JsonSerializable()
class SpeakingP2QuestionModel {
  final String question;
  final String suggest;

  SpeakingP2QuestionModel({
    required this.question,
    required this.suggest,
  });

  factory SpeakingP2QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakingP2QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakingP2QuestionModelToJson(this);

  SpeakingP2QuestionEntity toEntity() => SpeakingP2QuestionEntity(
        question: question,
        suggest: suggest,
      );
}
