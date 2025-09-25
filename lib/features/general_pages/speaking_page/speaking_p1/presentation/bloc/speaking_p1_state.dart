import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/entities/speaking_p1_entity.dart';

enum RecordingStatus { initial, recording, stopped, playing }

class SpeakingP1State extends BaseBlocState<SpeakingP1State> {
  final bool isLoading;
  final String error;
  final List<SpeakingP1Entity> listQuestion;

  final RecordingStatus recordingStatus;
  final String? recordingPath; // Đường dẫn tới file ghi âm tạm thời
  final Duration recordingDuration; // Thời gian đã ghi âm
  final Duration totalDuration; // Tổng thời gian của file ghi âm
  final Duration currentPosition; // Vị trí đang phát lại
  final int timeLimitInSeconds;

  SpeakingP1State({
    this.isLoading = false,
    this.error = "",
    this.listQuestion = const [],
    this.recordingStatus = RecordingStatus.initial,
    this.recordingPath,
    this.recordingDuration = Duration.zero,
    this.totalDuration = Duration.zero,
    this.currentPosition = Duration.zero,
    this.timeLimitInSeconds = 5,
  });

  @override
  SpeakingP1State copyWith({
    bool? isLoading,
    String? error,
    List<SpeakingP1Entity>? listQuestion,
    RecordingStatus? recordingStatus,
    String? recordingPath,
    Duration? recordingDuration,
    Duration? totalDuration,
    Duration? currentPosition,
    int? timeLimitInSeconds,
  }) {
    return SpeakingP1State(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      listQuestion: listQuestion ?? this.listQuestion,
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
        recordingStatus,
        recordingPath,
        recordingDuration,
        totalDuration,
        currentPosition,
        timeLimitInSeconds
      ];
}