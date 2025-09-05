sealed class ReadingP5Event {}

class LoadQuestions extends ReadingP5Event {
  final int? page;
  final int? limit;
  LoadQuestions({this.page, this.limit});
}

class PreviousQuestion extends ReadingP5Event {}

class NextQuestion extends ReadingP5Event {}

class CheckAnswer extends ReadingP5Event {}

class AnswerSelected extends ReadingP5Event {
  final int paragraphId;
  final int? selectedHeaderId;
  AnswerSelected(this.paragraphId, this.selectedHeaderId);
}
