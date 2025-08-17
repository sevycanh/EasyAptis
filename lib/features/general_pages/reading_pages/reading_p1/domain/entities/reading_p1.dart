import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/entities/option_r1_entity.dart';
import 'package:equatable/equatable.dart';

class ReadingP1Entity extends Equatable {
  final int index;
  final String questionText;
  final List<OptionR1Entity> options;

  const ReadingP1Entity({
    required this.index,
    required this.questionText,
    required this.options,
  });

  ReadingP1Entity copyWith({
    int? index,
    String? questionText,
    List<OptionR1Entity>? options,
  }) {
    return ReadingP1Entity(
      index: index ?? this.index,
      questionText: questionText ?? this.questionText,
      options: options ?? this.options,
    );
  }

  @override
  List<Object?> get props => [index, questionText, options];
}
