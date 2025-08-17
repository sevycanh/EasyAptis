// data/models/reading_p1_model.dart
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/entities/reading_p1.dart';
import 'package:json_annotation/json_annotation.dart';
import 'option_r1_model.dart';

part 'reading_p1_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReadingP1Model {
  final int index;
  final String questionText;
  final List<OptionR1Model> options;

  const ReadingP1Model({
    required this.index,
    required this.questionText,
    required this.options,
  });

  factory ReadingP1Model.fromJson(Map<String, dynamic> json) =>
      _$ReadingP1ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingP1ModelToJson(this);

  // Convert sang domain entity
  ReadingP1Entity toEntity() {
    return ReadingP1Entity(
      index: index,
      questionText: questionText,
      options: options.map((m) => m.toEntity()).toList(),
    );
  }
}
