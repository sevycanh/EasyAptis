import 'package:equatable/equatable.dart';

class SpeakingP2Entity extends Equatable {
  final int index;
  final String image;
  final List<SpeakingP2QuestionEntity> questions;

  const SpeakingP2Entity({
    required this.index,
    required this.image,
    required this.questions,
  });

  @override
  List<Object?> get props => [index, image, questions];
}

class SpeakingP2QuestionEntity extends Equatable {
  final String question;
  final String suggest;

  const SpeakingP2QuestionEntity({
    required this.question,
    required this.suggest,
  });

  @override
  List<Object?> get props => [question, suggest];
}
