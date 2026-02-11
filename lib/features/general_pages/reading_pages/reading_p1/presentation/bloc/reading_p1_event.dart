sealed class ReadingP1Event {}

class GetReadingP1Event extends ReadingP1Event {
  final int? page;
  final int? limit;
  final bool? forceRefresh;
  GetReadingP1Event({this.page, this.limit,this.forceRefresh});
}

class AnswerSelected extends ReadingP1Event {
  final int questionIndex;
  final int optionIndex;

  AnswerSelected(this.questionIndex, this.optionIndex);
}

class CheckAnswersEvent extends ReadingP1Event {}

class LoadMoreQuestionsEvent extends ReadingP1Event {}
