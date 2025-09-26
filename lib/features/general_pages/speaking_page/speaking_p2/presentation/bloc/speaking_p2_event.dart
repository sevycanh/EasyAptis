sealed class SpeakingP2Event {}

class LoadQuestions extends SpeakingP2Event {
  final int? page;
  final int? limit;
  LoadQuestions({this.page, this.limit});
}

class StartRecording extends SpeakingP2Event {
  final int timeLimitInSeconds;
  StartRecording({required this.timeLimitInSeconds});
}

class StopRecording extends SpeakingP2Event {}
class PlayRecording extends SpeakingP2Event {}
class PausePlayback extends SpeakingP2Event {}
class ResetRecording extends SpeakingP2Event {}


class UpdateRecordingTimer extends SpeakingP2Event {
  final Duration duration;
  UpdateRecordingTimer(this.duration);
}

class SeekPlayback extends SpeakingP2Event {
  final Duration position;
  SeekPlayback(this.position);
}

class NextPart extends SpeakingP2Event {}
class PreviousPart extends SpeakingP2Event {}
