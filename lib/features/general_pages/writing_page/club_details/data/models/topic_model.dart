import 'package:easyaptis/features/general_pages/writing_page/club_details/domain/entities/topic_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TopicModel {
  final int id;
  final String name;
  final String description;
  final Map<String, PartModel> parts;

  TopicModel({
    required this.id,
    required this.name,
    required this.description,
    required this.parts,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopicModelToJson(this);

  TopicEntity toEntity() => TopicEntity(
        id: id,
        name: name,
        description: description,
        parts: parts.map((k, v) => MapEntry(k, v.toEntity())),
      );
}

@JsonSerializable(explicitToJson: true)
class PartModel {
  final String? announcement;
  final List<QuestionModel> questions;

  PartModel({
    this.announcement,
    required this.questions,
  });

  factory PartModel.fromJson(Map<String, dynamic> json) =>
      _$PartModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartModelToJson(this);

  PartEntity toEntity() => PartEntity(
        announcement: announcement,
        questions: questions.map((q) => q.toEntity()).toList(),
      );
}

@JsonSerializable()
class QuestionModel {
  final int id;
  final String text;

  QuestionModel({
    required this.id,
    required this.text,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  QuestionEntity toEntity() => QuestionEntity(
        id: id,
        text: text,
      );
}
