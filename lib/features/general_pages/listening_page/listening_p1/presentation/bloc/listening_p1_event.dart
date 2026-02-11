sealed class ListeningP1Event {}

class LoadQuestions extends ListeningP1Event {
  final int? page;
  final int? limit;
  LoadQuestions({this.page, this.limit});
}

class PreviousQuestion extends ListeningP1Event {}

class NextQuestion extends ListeningP1Event {}

class CheckAnswer extends ListeningP1Event {}

class AnswerSelected extends ListeningP1Event {
  final int questionIndex; 
  final int optionIndex;  
  AnswerSelected(this.questionIndex, this.optionIndex);
}

class ToggleTranscript extends ListeningP1Event {
  final int questionIndex;
  ToggleTranscript(this.questionIndex);
}

class ToggleAudio extends ListeningP1Event {
  final String url;
  ToggleAudio(this.url);
}

class AudioCompleted extends ListeningP1Event {}

class JumpToTopic extends ListeningP1Event {
  final int index;
  JumpToTopic(this.index);
}