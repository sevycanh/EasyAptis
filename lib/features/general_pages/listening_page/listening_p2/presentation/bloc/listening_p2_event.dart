sealed class ListeningP2Event {}

class LoadQuestions extends ListeningP2Event {
  final int? page;
  final int? limit;
  LoadQuestions({this.page, this.limit});
}

class PreviousQuestion extends ListeningP2Event {}

class NextQuestion extends ListeningP2Event {}

class CheckAnswer extends ListeningP2Event {}

class AnswerSelected extends ListeningP2Event {
  final int questionIndex;
  final int speakerIndex;
  final int optionIndex;
  AnswerSelected(this.questionIndex, this.speakerIndex, this.optionIndex);
}

class ToggleTranscript extends ListeningP2Event {
  final int questionIndex;
  ToggleTranscript(this.questionIndex);
}

class ToggleAudio extends ListeningP2Event {
  final String url;
  ToggleAudio(this.url);
}

class AudioCompleted extends ListeningP2Event {}

class JumpToTopic extends ListeningP2Event {
  final int index;
  JumpToTopic(this.index);
}