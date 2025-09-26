import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/speaking_p3_entity.dart';

part 'speaking_p3_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SpeakingP3Model {
  final int index;
  final List<String> image;
  final List<SpeakingP3QuestionModel> questions;

  SpeakingP3Model({
    required this.index,
    required this.image,
    required this.questions,
  });

  factory SpeakingP3Model.fromJson(Map<String, dynamic> json) =>
      _$SpeakingP3ModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakingP3ModelToJson(this);

  SpeakingP3Entity toEntity() => SpeakingP3Entity(
        index: index,
        image: image,
        questions: questions.map((q) => q.toEntity()).toList(),
      );
}

@JsonSerializable()
class SpeakingP3QuestionModel {
  final String question;
  final String suggest;

  SpeakingP3QuestionModel({
    required this.question,
    required this.suggest,
  });

  factory SpeakingP3QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakingP3QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakingP3QuestionModelToJson(this);

  SpeakingP3QuestionEntity toEntity() => SpeakingP3QuestionEntity(
        question: question,
        suggest: suggest,
      );
}
