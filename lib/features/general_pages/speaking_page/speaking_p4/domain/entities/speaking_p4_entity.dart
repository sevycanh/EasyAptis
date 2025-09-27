import 'package:equatable/equatable.dart';

class SpeakingP4Entity extends Equatable {
  final int index;
  final List<SpeakingP4QuestionEntity> questions;

  const SpeakingP4Entity({
    required this.index,
    required this.questions,
  });

  @override
  List<Object?> get props => [index, questions];
}

class SpeakingP4QuestionEntity extends Equatable {
  final int id;
  final String question;
  final String suggest;

  const SpeakingP4QuestionEntity({
    required this.id,
    required this.question,
    required this.suggest,
  });

  @override
  List<Object?> get props => [id, question, suggest];
}
