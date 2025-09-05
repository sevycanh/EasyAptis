sealed class ReadingP4Event {}

class LoadQuestions extends ReadingP4Event {
  final int? page;
  final int? limit;
  LoadQuestions({this.page, this.limit});
}

class PreviousQuestion extends ReadingP4Event {}

class NextQuestion extends ReadingP4Event {}

class CheckAnswer extends ReadingP4Event {}

class AnswerSelected extends ReadingP4Event {
  final int questionIndex;
  final String? selectedSpeaker;
  AnswerSelected(this.questionIndex, this.selectedSpeaker);
}