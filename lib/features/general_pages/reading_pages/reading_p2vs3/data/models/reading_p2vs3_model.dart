import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/entities/reading_p2vs3_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reading_p2vs3_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReadingP2vs3Model {
  final int index;
  final String questionText;
  final List<OptionP2vs3Model> options;

  ReadingP2vs3Model({
    required this.index,
    required this.questionText,
    required this.options,
  });

  factory ReadingP2vs3Model.fromJson(Map<String, dynamic> json) =>
      _$ReadingP2vs3ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingP2vs3ModelToJson(this);

  ReadingP2vs3Entity toEntity() => ReadingP2vs3Entity(
    index: index,
    questionText: questionText,
    options: options.map((option) => option.toEntity()).toList(),
  );
}

@JsonSerializable()
class OptionP2vs3Model {
  final int id;
  final String text;

  OptionP2vs3Model({required this.id, required this.text});

  factory OptionP2vs3Model.fromJson(Map<String, dynamic> json) =>
      _$OptionP2vs3ModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionP2vs3ModelToJson(this);

  OptionR2vs3Entity toEntity() => OptionR2vs3Entity(text: text, id: id);
}
