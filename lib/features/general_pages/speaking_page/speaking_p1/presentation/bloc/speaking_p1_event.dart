sealed class SpeakingP1Event {}

class LoadQuestions extends SpeakingP1Event {
  final int? page;
  final int? limit;
  LoadQuestions({this.page, this.limit});
}

class StartRecording extends SpeakingP1Event {
  final int timeLimitInSeconds;
  StartRecording({required this.timeLimitInSeconds});
}

class StopRecording extends SpeakingP1Event {}
class PlayRecording extends SpeakingP1Event {}
class PausePlayback extends SpeakingP1Event {}
class ResetRecording extends SpeakingP1Event {}


class UpdateRecordingTimer extends SpeakingP1Event {
  final Duration duration;
  UpdateRecordingTimer(this.duration);
}

class SeekPlayback extends SpeakingP1Event {
  final Duration position;
  SeekPlayback(this.position);
}

class LoadMoreQuestionsEvent extends SpeakingP1Event {}