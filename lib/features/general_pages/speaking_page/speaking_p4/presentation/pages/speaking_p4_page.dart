import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/widgets/app_button.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/domain/entities/speaking_p4_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/presentation/bloc/speaking_p4_bloc.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/presentation/bloc/speaking_p4_event.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/presentation/bloc/speaking_p4_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';

class SpeakingP4Page
    extends BaseBlocWidget<SpeakingP4Event, SpeakingP4State, SpeakingP4Bloc> {
  SpeakingP4Page({super.key, this.page, this.limit})
    : super(sl<SpeakingP4Bloc>());

  final int? page;
  final int? limit;

  @override
  void onInit() {
    super.onInit();
    bloc.add(LoadQuestions(page: page, limit: limit));
  }

  @override
  void onStateChanged(BuildContext context, SpeakingP4State state) {
    if (state.error.isNotEmpty && state.listQuestion.isEmpty) {}
  }

  @override
  Widget buildWidget(
    BuildContext context,
    SpeakingP4Bloc bloc,
    SpeakingP4State state,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Speaking Part 4"),
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

  Widget _buildPageBody(BuildContext context, SpeakingP4State state) {
    if (state.error.isNotEmpty && state.listQuestion.isEmpty) {
      return Center(child: Text("Có lỗi xảy ra: ${state.error}"));
    }
    if (state.listQuestion.isEmpty) {
      return const Center(child: Text("Chưa có dữ liệu"));
    }
    return _buildQuestionList(state.listQuestion, state.currentIndex);
  }

  Widget _buildQuestionList(
    List<SpeakingP4Entity> questions,
    int currentIndex,
  ) {
    final item = questions[currentIndex];
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Page ${currentIndex + 1} of ${questions.length}",
              style: AppTextStyle.xLargeBlackBold,
            ),
            ...item.questions.map(
              (q) => Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gray,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: SelectableText(
                    "${item.questions.indexOf(q) + 1}. ${q.question}",
                    style: AppTextStyle.xLargeBlackBold,
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SelectableText(
                          q.suggest,
                          style: AppTextStyle.xLargeBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPlayer(
    BuildContext context,
    SpeakingP4Bloc bloc,
    SpeakingP4State state,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
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
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Previous",
                    color: AppColors.pastel,
                    onPressed:
                        state.currentIndex > 0
                            ? () => bloc.add(PreviousPart())
                            : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: "Next",
                    color: AppColors.green,
                    onPressed:
                        state.currentIndex < state.listQuestion.length - 1
                            ? () => bloc.add(NextPart())
                            : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(
    BuildContext context,
    SpeakingP4Bloc bloc,
    SpeakingP4State state,
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
    SpeakingP4Bloc bloc,
    SpeakingP4State state,
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

  Widget _buildMainControlButton(SpeakingP4Bloc bloc, SpeakingP4State state) {
    switch (state.recordingStatus) {
      case RecordingStatus.recording:
        return FloatingActionButton(
          onPressed: () => bloc.add(StopRecording()),
          backgroundColor: AppColors.blue,
          elevation: 0,
          child: const Icon(Icons.stop, color: Colors.white),
        );
      case RecordingStatus.playing:
        return FloatingActionButton(
          onPressed: () => bloc.add(PausePlayback()),
          backgroundColor: AppColors.secondaryColor,
          elevation: 0,
          child: const Icon(Icons.pause, color: Colors.white),
        );
      case RecordingStatus.stopped:
        return FloatingActionButton(
          onPressed: () => bloc.add(PlayRecording()),
          backgroundColor: Colors.green,
          elevation: 0,
          child: const Icon(Icons.play_arrow, color: Colors.white),
        );
      case RecordingStatus.initial:
        return FloatingActionButton(
          onPressed:
              () => bloc.add(
                StartRecording(timeLimitInSeconds: state.timeLimitInSeconds),
              ),
          backgroundColor: Colors.red,
          elevation: 0,
          child: const Icon(Icons.mic, color: Colors.white),
        );
    }
  }
}
