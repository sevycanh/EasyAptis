// speaking_p1_model.dart
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/entities/speaking_p1_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'speaking_p1_model.g.dart';

@JsonSerializable()
class SpeakingP1Model {
  final int index;
  final String question;
  final String suggest;

  SpeakingP1Model({
    required this.index,
    required this.question,
    required this.suggest,
  });

  /// Factory từ JSON
  factory SpeakingP1Model.fromJson(Map<String, dynamic> json) =>
      _$SpeakingP1ModelFromJson(json);

  /// Convert về JSON
  Map<String, dynamic> toJson() => _$SpeakingP1ModelToJson(this);

  /// Convert sang Entity
  SpeakingP1Entity toEntity() {
    return SpeakingP1Entity(
      index: index,
      question: question,
      suggest: suggest,
    );
  }
}
