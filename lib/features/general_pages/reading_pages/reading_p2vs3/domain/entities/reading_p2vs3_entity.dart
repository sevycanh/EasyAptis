import 'package:equatable/equatable.dart';

class ReadingP2vs3Entity extends Equatable {
  final int index;
  final String questionText;
  final List<OptionR2vs3Entity> options;

  const ReadingP2vs3Entity({
    required this.index,
    required this.questionText,
    required this.options,
  });

  @override
  List<Object?> get props => [index, questionText, options];
}

class OptionR2vs3Entity extends Equatable {
  final String text;
  final int id;

  const OptionR2vs3Entity({
    required this.text,
    required this.id,
  });

  @override
  List<Object?> get props => [text, id];
}