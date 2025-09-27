sealed class SpeakingP4Event {}

class LoadQuestions extends SpeakingP4Event {
  final int? page;
  final int? limit;
  LoadQuestions({this.page, this.limit});
}

class StartRecording extends SpeakingP4Event {
  final int timeLimitInSeconds;
  StartRecording({required this.timeLimitInSeconds});
}

class StopRecording extends SpeakingP4Event {}
class PlayRecording extends SpeakingP4Event {}
class PausePlayback extends SpeakingP4Event {}
class ResetRecording extends SpeakingP4Event {}


class UpdateRecordingTimer extends SpeakingP4Event {
  final Duration duration;
  UpdateRecordingTimer(this.duration);
}

class SeekPlayback extends SpeakingP4Event {
  final Duration position;
  SeekPlayback(this.position);
}

class NextPart extends SpeakingP4Event {}
class PreviousPart extends SpeakingP4Event {}
