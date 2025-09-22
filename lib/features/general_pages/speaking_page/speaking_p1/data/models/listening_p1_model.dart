import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/entities/listening_p1_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listening_p1_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ListeningP1Model {
  final int index;
  final String question;
  @JsonKey(name: 'audio_url')
  final String audioUrl;
  final String transcript;
  final List<ListeningP1OptionModel> options;

  const ListeningP1Model({
    required this.index,
    required this.question,
    required this.audioUrl,
    required this.transcript,
    required this.options,
  });

  factory ListeningP1Model.fromJson(Map<String, dynamic> json) =>
      _$ListeningP1ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningP1ModelToJson(this);

  ListeningP1Entity toEntity() {
    return ListeningP1Entity(
      index: index,
      question: question,
      audioUrl: audioUrl,
      transcript: transcript,
      options: options.map((o) => o.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class ListeningP1OptionModel {
  final bool isCorrect;
  final String text;

  const ListeningP1OptionModel({
    required this.isCorrect,
    required this.text,
  });

  factory ListeningP1OptionModel.fromJson(Map<String, dynamic> json) =>
      _$ListeningP1OptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningP1OptionModelToJson(this);

  ListeningP1OptionEntity toEntity() {
    return ListeningP1OptionEntity(
      isCorrect: isCorrect,
      text: text,
    );
  }
}
