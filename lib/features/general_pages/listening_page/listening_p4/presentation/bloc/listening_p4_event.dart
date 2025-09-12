sealed class ListeningP4Event {}

class LoadQuestions extends ListeningP4Event {
  final int? page;
  final int? limit;
  LoadQuestions({this.page, this.limit});
}

class PreviousQuestion extends ListeningP4Event {}

class NextQuestion extends ListeningP4Event {}

class CheckAnswer extends ListeningP4Event {}

class AnswerSelected extends ListeningP4Event {
  final int audioIndex;
  final int questionId;
  final int optionIndex;
  AnswerSelected(this.audioIndex, this.questionId, this.optionIndex);
}

class ToggleTranscript extends ListeningP4Event {
  final int questionIndex;
  ToggleTranscript(this.questionIndex);
}

class ToggleAudio extends ListeningP4Event {
  final String url;
  ToggleAudio(this.url);
}

class AudioCompleted extends ListeningP4Event {}
