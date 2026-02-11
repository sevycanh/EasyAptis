import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/widgets/app_button.dart';
import 'package:easyaptis/core/widgets/app_loading.dart';
import 'package:easyaptis/core/widgets/app_select_bottom_sheet.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/presentation/bloc/listening_p1_bloc.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/presentation/bloc/listening_p1_event.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/presentation/bloc/listening_p1_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';

class ListeningP1Page
    extends
        BaseBlocWidget<ListeningP1Event, ListeningP1State, ListeningP1Bloc> {
  ListeningP1Page({super.key, this.page, this.limit})
    : super(sl<ListeningP1Bloc>());

  final int? page;
  final int? limit;

  @override
  void onInit() {
    super.onInit();
    bloc.add(LoadQuestions(page: page, limit: limit));
  }

  @override
  void onStateChanged(BuildContext context, ListeningP1State state) {}

  @override
  Widget buildWidget(
    BuildContext context,
    ListeningP1Bloc bloc,
    ListeningP1State state,
  ) {
    if (state.isLoading) {
      return AppLoading();
    }

    Widget body;
    if (state.error.isNotEmpty) {
      body = Center(child: Text("Có lỗi xảy ra!"));
    } else if (state.listQuestion.isEmpty) {
      body = const Center(child: Text("Chưa có dữ liệu"));
    } else {
      body = _buildBody(context, bloc, state);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Listening Part 1"),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt_rounded),
            tooltip: "Chọn Topic",
            onPressed: () async => await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return AppSelectorBottomSheet(
                  title: "All Questions",
                  items: List.generate(
                    state.listQuestion.length,
                    (index) => AppSelectorItem(
                      title:
                          "${index + 1}. ${state.listQuestion[index].question}",
                      isSelected: index == state.currentIndex,
                    ),
                  ),
                  onItemSelected: (index) {
                    bloc.add(JumpToTopic(index));
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  text: "Back",
                  textStyle: state.currentIndex == 0
                      ? AppTextStyle.largeBlack.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGray,
                          letterSpacing: 1,
                        )
                      : null,
                  color: AppColors.pastel,
                  fixWidth: true,
                  onPressed: state.currentIndex == 0
                      ? null
                      : () => bloc.add(PreviousQuestion()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: "Check",
                  color: AppColors.primaryColor,
                  fixWidth: true,
                  onPressed: () => bloc.add(CheckAnswer()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: "Next",
                  textStyle: state.currentIndex == state.listQuestion.length - 1
                      ? AppTextStyle.largeBlack.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGray,
                          letterSpacing: 1,
                        )
                      : null,
                  fixWidth: true,
                  color: AppColors.green,
                  onPressed: state.currentIndex == state.listQuestion.length - 1
                      ? null
                      : () => bloc.add(NextQuestion()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ListeningP1Bloc bloc,
    ListeningP1State state,
  ) {
    final question = state.listQuestion[state.currentIndex];
    final showTranscript = state.transcriptVisible.contains(state.currentIndex);
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      state.isPlaying ? Icons.stop : Icons.play_arrow,
                      size: 32,
                    ),
                    onPressed: () {
                      bloc.add(ToggleAudio(question.audioUrl));
                    },
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    showTranscript ? Icons.visibility : Icons.visibility_off,
                  ),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    bloc.add(ToggleTranscript(state.currentIndex));
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.lightGray, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    "${state.currentIndex + 1}. ${question.question}",
                    style: AppTextStyle.xLargeBlackBold,
                  ),
                  ...List.generate(question.options.length, (i) {
                    final option = question.options[i];

                    Widget iconWidget = const SizedBox(width: 24, height: 24);

                    final selectedIdx =
                        state.selectedAnswers[state.currentIndex];
                    final correctIdx = state.correctAnswers[state.currentIndex];

                    if (correctIdx != null) {
                      if (i == correctIdx) {
                        if (selectedIdx == null) {
                          iconWidget = const Icon(
                            Icons.check_circle,
                            color: AppColors.gray,
                          );
                        } else if (selectedIdx == correctIdx) {
                          iconWidget = const Icon(
                            Icons.check_circle,
                            color: AppColors.green,
                          );
                        } else {
                          iconWidget = const Icon(
                            Icons.check_circle,
                            color: AppColors.gray,
                          );
                        }
                      } else if (i == selectedIdx &&
                          selectedIdx != correctIdx) {
                        iconWidget = const Icon(
                          Icons.cancel,
                          color: AppColors.red,
                        );
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: RadioListTile<int>(
                        value: i,
                        groupValue: selectedIdx,
                        onChanged: (val) {
                          if (val != null) {
                            bloc.add(AnswerSelected(state.currentIndex, val));
                          }
                        },
                        title: SelectableText(option.text),
                        activeColor: AppColors.secondaryColor,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        secondary: SizedBox(
                          width: 24,
                          height: 24,
                          child: Center(child: iconWidget),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            // const SizedBox(height: 16),
            // AppButton(
            //   fixWidth: true,
            //   onPressed: () {
            //     bloc.add(ToggleTranscript(state.currentIndex));
            //   },
            //   text: showTranscript ? "Close Transcript" : "Show Transcript",
            //   color: AppColors.linkColor,
            //   textStyle: AppTextStyle.largeWhite.copyWith(
            //     fontWeight: FontWeight.bold,
            //     letterSpacing: 1,
            //   ),
            // ),
            if (showTranscript) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.lightGray, width: 2),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Transcript",
                        style: AppTextStyle.largeBlackBold.copyWith(
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      question.transcript,
                      style: AppTextStyle.largeBlack,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
