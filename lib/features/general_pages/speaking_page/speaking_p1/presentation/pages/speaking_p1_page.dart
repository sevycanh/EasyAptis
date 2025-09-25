import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/entities/speaking_p1_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/presentation/bloc/speaking_p1_bloc.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/presentation/bloc/speaking_p1_event.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/presentation/bloc/speaking_p1_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:easyaptis/shared/presentation/models/suggest_ui_model.dart';
import 'package:easyaptis/shared/presentation/widgets/suggest_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SpeakingP1Page
    extends BaseBlocWidget<SpeakingP1Event, SpeakingP1State, SpeakingP1Bloc> {
  SpeakingP1Page({super.key, this.page, this.limit})
    : super(sl<SpeakingP1Bloc>());

  final int? page;
  final int? limit;

  @override
  void onInit() {
    super.onInit();
    bloc.add(LoadQuestions(page: page, limit: limit));
  }

  @override
  void onStateChanged(BuildContext context, SpeakingP1State state) {
    if (state.error.isNotEmpty && state.listQuestion.isEmpty) {}
  }

  @override
  Widget buildWidget(
    BuildContext context,
    SpeakingP1Bloc bloc,
    SpeakingP1State state,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Speaking Part 1"),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: _buildPageBody(context, state),
      bottomNavigationBar: _buildBottomPlayer(context, bloc, state),
    );
  }

  Widget _buildPageBody(BuildContext context, SpeakingP1State state) {
    if (state.error.isNotEmpty && state.listQuestion.isEmpty) {
      return Center(child: Text("Có lỗi xảy ra: ${state.error}"));
    }
    if (state.listQuestion.isEmpty) {
      return const Center(child: Text("Chưa có dữ liệu"));
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Row(
            children: [
              Text(
                "30s/question",
                style: AppTextStyle.xxLargeBlackBold.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.lightbulb_outline),
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                onPressed: () {
                  _showSuggestBottomSheet(context, state);
                },
              ),
            ],
          ),
        ),
        _buildQuestionList(state.listQuestion),
      ],
    );
  }

  Widget _buildQuestionList(List<SpeakingP1Entity> questions) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: questions.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final question = questions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SelectableText(
              "${question.index}. ${question.question}",
              style: AppTextStyle.xLargeBlack,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomPlayer(
    BuildContext context,
    SpeakingP1Bloc bloc,
    SpeakingP1State state,
  ) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: _buildControlsSection(context, bloc, state),
            ),
            Expanded(
              flex: 1,
              child: _buildProgressSection(context, bloc, state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(
    BuildContext context,
    SpeakingP1Bloc bloc,
    SpeakingP1State state,
  ) {
    if (state.recordingStatus == RecordingStatus.recording) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          'Recording...',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    if (state.recordingStatus == RecordingStatus.stopped) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          'Recorded',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    if (state.recordingStatus == RecordingStatus.playing) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          'Playing...',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        'Not recorded',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildControlsSection(
    BuildContext context,
    SpeakingP1Bloc bloc,
    SpeakingP1State state,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.refresh, color: Colors.grey),
            iconSize: 32,
            onPressed:
                state.recordingPath != null &&
                        state.recordingStatus != RecordingStatus.playing
                    ? () => bloc.add(ResetRecording())
                    : null,
          ),
        ),

        Expanded(child: _buildMainControlButton(bloc, state)),

        // _buildTimeLimitDropdown(bloc, state),
      ],
    );
  }

  Widget _buildMainControlButton(SpeakingP1Bloc bloc, SpeakingP1State state) {
    switch (state.recordingStatus) {
      case RecordingStatus.recording:
        return FloatingActionButton(
          onPressed: () => bloc.add(StopRecording()),
          backgroundColor: AppColors.blue,
          child: const Icon(Icons.stop, color: Colors.white),
        );
      case RecordingStatus.playing:
        return FloatingActionButton(
          onPressed: () => bloc.add(PausePlayback()),
          backgroundColor: AppColors.secondaryColor,
          child: const Icon(Icons.pause, color: Colors.white),
        );
      case RecordingStatus.stopped:
        return FloatingActionButton(
          onPressed: () => bloc.add(PlayRecording()),
          backgroundColor: Colors.green,
          child: const Icon(Icons.play_arrow, color: Colors.white),
        );
      case RecordingStatus.initial:
        return FloatingActionButton(
          onPressed:
              () => bloc.add(
                StartRecording(timeLimitInSeconds: state.timeLimitInSeconds),
              ),
          backgroundColor: Colors.red,
          child: const Icon(Icons.mic, color: Colors.white),
        );
    }
  }

  // Widget _buildTimeLimitDropdown(SpeakingP1Bloc bloc, SpeakingP1State state) {
  //   return DropdownButton<int>(
  //     value: state.timeLimitInSeconds,
  //     // Chỉ cho phép thay đổi khi ở trạng thái ban đầu
  //     onChanged:
  //         state.recordingStatus == RecordingStatus.initial
  //             ? (newValue) {
  //               if (newValue != null) {
  //                 // Có thể tạo một Event mới để cập nhật timeLimit trong BLoC
  //                 // bloc.add(SetTimeLimit(newValue));
  //               }
  //             }
  //             : null,
  //     items:
  //         <int>[30, 45, 60, 90].map<DropdownMenuItem<int>>((int value) {
  //           return DropdownMenuItem<int>(value: value, child: Text('$value s'));
  //         }).toList(),
  //   );
  // }
}

void _showSuggestBottomSheet(BuildContext context, SpeakingP1State state) {
  final suggestions =
      state.listQuestion.map((q) {
        return SuggestUiModel(
          id: q.index.toString(),
          title: q.question,
          suggestion: q.suggest,
        );
      }).toList();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: AppColors.white,
    builder: (_) => SuggestBottomSheet(suggestions: suggestions),
  );
}
