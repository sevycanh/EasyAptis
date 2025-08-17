sealed class ReadingP1Event {}

class GetReadingP1Event extends ReadingP1Event {
  final int? page;
  final int? limit;
  GetReadingP1Event({this.page, this.limit});
}

class SelectAnswerEvent extends ReadingP1Event {
  final int questionIndex;
  final int optionIndex;

  SelectAnswerEvent(this.questionIndex, this.optionIndex);
}

class SubmitAnswersEvent extends ReadingP1Event {}

class ResetAnswersEvent extends ReadingP1Event {}