import 'package:equatable/equatable.dart';

class ListeningP4Entity extends Equatable {
  final String index;
  final String audioUrl;
  final String topic;
  final String transcript;
  final List<ListeningP4QuestionEntity> questions;

  const ListeningP4Entity({
    required this.index,
    required this.audioUrl,
    required this.topic,
    required this.transcript,
    required this.questions,
  });

  @override
  List<Object?> get props => [index, audioUrl, topic, transcript, questions];
}

class ListeningP4QuestionEntity extends Equatable {
  final int id;
  final String text;
  final List<ListeningP4OptionEntity> options;

  const ListeningP4QuestionEntity({
    required this.id,
    required this.text,
    required this.options,
  });

  @override
  List<Object?> get props => [id, text, options];
}

class ListeningP4OptionEntity extends Equatable {
  final String text;
  final bool isCorrect;

  const ListeningP4OptionEntity({
    required this.text,
    required this.isCorrect,
  });

  @override
  List<Object?> get props => [text, isCorrect];
}
