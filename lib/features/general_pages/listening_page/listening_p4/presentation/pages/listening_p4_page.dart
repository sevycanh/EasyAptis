import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/utils/widgets/app_button.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/presentation/bloc/listening_p4_bloc.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/presentation/bloc/listening_p4_event.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/presentation/bloc/listening_p4_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';

class ListeningP4Page
    extends
        BaseBlocWidget<ListeningP4Event, ListeningP4State, ListeningP4Bloc> {
  ListeningP4Page({super.key, this.page, this.limit})
    : super(sl<ListeningP4Bloc>());

  final int? page;
  final int? limit;

  @override
  void onInit() {
    super.onInit();
    bloc.add(LoadQuestions(page: page, limit: limit));
  }

  @override
  void onStateChanged(BuildContext context, ListeningP4State state) {}

  @override
  Widget buildWidget(
    BuildContext context,
    ListeningP4Bloc bloc,
    ListeningP4State state,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
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
              AppButton(
                text: "Previous",
                color: AppColors.pastel,
                fixWidth: true,
                onPressed:
                    state.currentIndex == 0
                        ? null
                        : () => bloc.add(PreviousQuestion()),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: "Check result",
                  color: AppColors.primaryColor,
                  fixWidth: true,
                  onPressed: () => bloc.add(CheckAnswer()),
                ),
              ),
              const SizedBox(width: 12),
              AppButton(
                text: "Next",
                fixWidth: true,
                color: AppColors.green,
                onPressed:
                    state.currentIndex == state.listQuestion.length - 1
                        ? null
                        : () => bloc.add(NextQuestion()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ListeningP4Bloc bloc,
    ListeningP4State state,
  ) {
    final entity = state.listQuestion[state.currentIndex];
    final showTranscript = state.transcriptVisible.contains(state.currentIndex);
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.lightGray, width: 2),
              ),
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
                            bloc.add(ToggleAudio(entity.audioUrl));
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          "Topic ${state.currentIndex + 1}: ${entity.topic}",
                          style: AppTextStyle.xLargeBlackBold,
                        ),
                      ),
                    ],
                  ),

                  if (showTranscript) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.lightGray,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        entity.transcript,
                        style: AppTextStyle.largeBlack,
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // ✅ Hiển thị từng câu hỏi
                  ...entity.questions.map((q) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${q.id}. ${q.text}",
                          style: AppTextStyle.largeBlackBold,
                        ),
                        ...List.generate(q.options.length, (i) {
                          final option = q.options[i];

                          final selectedIdx =
                              state
                                  .selectedAnswers["${state.currentIndex}-${q.id}"];
                          final correctIdx =
                              state
                                  .correctAnswers["${state.currentIndex}-${q.id}"];

                          Widget iconWidget = const SizedBox(
                            width: 24,
                            height: 24,
                          );

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

                          return RadioListTile<int>(
                            value: i,
                            groupValue: selectedIdx,
                            onChanged: (val) {
                              if (val != null) {
                                bloc.add(
                                  AnswerSelected(state.currentIndex, q.id, val),
                                );
                              }
                            },
                            title: Text(option.text),
                            activeColor: AppColors.secondaryColor,
                            secondary: iconWidget,
                          );
                        }),
                        const SizedBox(height: 12),
                      ],
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppButton(
              fixWidth: true,
              onPressed: () {
                bloc.add(ToggleTranscript(state.currentIndex));
              },
              text: showTranscript ? "Close Transcript" : "Show Transcript",
              color: AppColors.linkColor,
              textStyle: AppTextStyle.largeWhite.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            if (showTranscript) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.lightGray, width: 2),
                ),
                child: Text(entity.transcript, style: AppTextStyle.largeBlack),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
