// data/models/option_r1_model.dart
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/option_r1_entity.dart';

part 'option_r1_model.g.dart';

@JsonSerializable()
class OptionR1Model {
  final String text;
  final bool isCorrect;

  const OptionR1Model({
    required this.text,
    required this.isCorrect,
  });

  factory OptionR1Model.fromJson(Map<String, dynamic> json) =>
      _$OptionR1ModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionR1ModelToJson(this);

  OptionR1Entity toEntity() =>
      OptionR1Entity(text: text, isCorrect: isCorrect);
}
