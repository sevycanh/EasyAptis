import 'package:equatable/equatable.dart';

class ListeningP1Entity extends Equatable {
  final int index;
  final String question;
  final String audioUrl;
  final String transcript;
  final List<ListeningP1OptionEntity> options;

  const ListeningP1Entity({
    required this.index,
    required this.question,
    required this.audioUrl,
    required this.transcript,
    required this.options,
  });

  @override
  List<Object?> get props => [index, question, audioUrl, transcript, options];
}

class ListeningP1OptionEntity extends Equatable {
  final bool isCorrect;
  final String text;

  const ListeningP1OptionEntity({
    required this.isCorrect,
    required this.text,
  });

  @override
  List<Object?> get props => [isCorrect, text];
}
