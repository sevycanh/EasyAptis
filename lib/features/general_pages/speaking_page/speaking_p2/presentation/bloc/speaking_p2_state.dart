import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/domain/entities/speaking_p2_entity.dart';

enum RecordingStatus { initial, recording, stopped, playing }

class SpeakingP2State extends BaseBlocState<SpeakingP2State> {
  final bool isLoading;
  final String error;
  final List<SpeakingP2Entity> listQuestion;
  final int currentIndex;

  final RecordingStatus recordingStatus;
  final String? recordingPath; 
  final Duration recordingDuration; 
  final Duration totalDuration; 
  final Duration currentPosition;
  final int timeLimitInSeconds;

  SpeakingP2State({
    this.isLoading = false,
    this.error = "",
    this.listQuestion = const [],
    this.currentIndex = 0,
    this.recordingStatus = RecordingStatus.initial,
    this.recordingPath,
    this.recordingDuration = Duration.zero,
    this.totalDuration = Duration.zero,
    this.currentPosition = Duration.zero,
    this.timeLimitInSeconds = 45,
  });

  @override
  SpeakingP2State copyWith({
    bool? isLoading,
    String? error,
    List<SpeakingP2Entity>? listQuestion,
    int? currentIndex,
    RecordingStatus? recordingStatus,
    String? recordingPath,
    Duration? recordingDuration,
    Duration? totalDuration,
    Duration? currentPosition,
    int? timeLimitInSeconds,
  }) {
    return SpeakingP2State(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      listQuestion: listQuestion ?? this.listQuestion,
      currentIndex: currentIndex ?? this.currentIndex,
      recordingStatus: recordingStatus ?? this.recordingStatus,
      recordingPath: recordingPath ?? this.recordingPath,
      recordingDuration: recordingDuration ?? this.recordingDuration,
      totalDuration: totalDuration ?? this.totalDuration,
      currentPosition: currentPosition ?? this.currentPosition,
      timeLimitInSeconds: timeLimitInSeconds ?? this.timeLimitInSeconds,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        listQuestion,
        currentIndex,
        recordingStatus,
        recordingPath,
        recordingDuration,
        totalDuration,
        currentPosition,
        timeLimitInSeconds
      ];
}
