import 'package:equatable/equatable.dart';

class OptionR1Entity extends Equatable {
  final String text;
  final bool isCorrect;

  const OptionR1Entity({
    required this.text,
    required this.isCorrect,
  });

  @override
  List<Object?> get props => [text, isCorrect];
}
