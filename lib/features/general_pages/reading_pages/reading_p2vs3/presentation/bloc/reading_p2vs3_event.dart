sealed class ReadingP2vs3Event {}

class LoadQuestions extends ReadingP2vs3Event {
  final int? limit;
  final int? page;
  LoadQuestions({this.limit, this.page});
}

class ReorderOption extends ReadingP2vs3Event {
  final int oldIndex;
  final int newIndex;
  ReorderOption(this.oldIndex, this.newIndex);
}

class CheckAnswer extends ReadingP2vs3Event {}

class NextQuestion extends ReadingP2vs3Event {}

class PreviousQuestion extends ReadingP2vs3Event {}

class JumpToQuestion extends ReadingP2vs3Event {
  final int index;
  JumpToQuestion(this.index);
}
