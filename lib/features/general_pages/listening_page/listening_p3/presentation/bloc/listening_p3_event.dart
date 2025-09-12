sealed class ListeningP3Event {}

class LoadQuestions extends ListeningP3Event {
  final int? page;
  final int? limit;
  LoadQuestions({this.page, this.limit});
}

class PreviousQuestion extends ListeningP3Event {}

class NextQuestion extends ListeningP3Event {}

class CheckAnswer extends ListeningP3Event {}

class AnswerSelected extends ListeningP3Event {
  final int questionIndex;
  final int statementId;
  final String answer; // "B", "M", "W"
  AnswerSelected(this.questionIndex, this.statementId, this.answer);
}

class ToggleTranscript extends ListeningP3Event {
  final int questionIndex;
  ToggleTranscript(this.questionIndex);
}

class ToggleAudio extends ListeningP3Event {
  final String url;
  ToggleAudio(this.url);
}

class AudioCompleted extends ListeningP3Event {}
