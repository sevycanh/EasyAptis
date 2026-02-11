sealed class SpeakingP3Event {}

class LoadQuestions extends SpeakingP3Event {
  final int? page;
  final int? limit;
  LoadQuestions({this.page, this.limit});
}

class StartRecording extends SpeakingP3Event {
  final int timeLimitInSeconds;
  StartRecording({required this.timeLimitInSeconds});
}

class StopRecording extends SpeakingP3Event {}
class PlayRecording extends SpeakingP3Event {}
class PausePlayback extends SpeakingP3Event {}
class ResetRecording extends SpeakingP3Event {}


class UpdateRecordingTimer extends SpeakingP3Event {
  final Duration duration;
  UpdateRecordingTimer(this.duration);
}

class SeekPlayback extends SpeakingP3Event {
  final Duration position;
  SeekPlayback(this.position);
}

class NextPart extends SpeakingP3Event {}
class PreviousPart extends SpeakingP3Event {}

class JumpToTopic extends SpeakingP3Event {
  final int index;
  JumpToTopic(this.index);
}