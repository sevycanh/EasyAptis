import 'package:equatable/equatable.dart';

class ReadingP4Entity extends Equatable {
  final int index;
  final String topic;
  final List<SpeakerR4Entity> speakers;
  final List<QuestionR4Entity> questions;

  const ReadingP4Entity({
    required this.index,
    required this.topic,
    required this.speakers,
    required this.questions,
  });

  @override
  List<Object?> get props => [index, topic, speakers, questions];
}

class SpeakerR4Entity extends Equatable {
  final String id;
  final String text;

  const SpeakerR4Entity({required this.id, required this.text});

  @override
  List<Object?> get props => [id, text];
}

class QuestionR4Entity extends Equatable {
  final int id;
  final String question;
  final String answer;

  const QuestionR4Entity({
    required this.id,
    required this.question,
    required this.answer,
  });

  @override
  List<Object?> get props => [id, question, answer];
}
