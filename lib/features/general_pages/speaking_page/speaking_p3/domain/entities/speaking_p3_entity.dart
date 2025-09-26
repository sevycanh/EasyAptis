import 'package:equatable/equatable.dart';

class SpeakingP3Entity extends Equatable {
  final int index;
  final List<String> image;
  final List<SpeakingP3QuestionEntity> questions;

  const SpeakingP3Entity({
    required this.index,
    required this.image,
    required this.questions,
  });

  @override
  List<Object?> get props => [index, image, questions];
}

class SpeakingP3QuestionEntity extends Equatable {
  final String question;
  final String suggest;

  const SpeakingP3QuestionEntity({
    required this.question,
    required this.suggest,
  });

  @override
  List<Object?> get props => [question, suggest];
}
