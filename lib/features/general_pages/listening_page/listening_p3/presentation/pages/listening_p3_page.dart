import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/widgets/app_button.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/entities/listening_p3_entity.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/presentation/bloc/listening_p3_bloc.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/presentation/bloc/listening_p3_event.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/presentation/bloc/listening_p3_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';

class ListeningP3Page
    extends
        BaseBlocWidget<ListeningP3Event, ListeningP3State, ListeningP3Bloc> {
  ListeningP3Page({super.key, this.page, this.limit})
    : super(sl<ListeningP3Bloc>());

  final int? page;
  final int? limit;

  @override
  void onInit() {
    super.onInit();
    bloc.add(LoadQuestions(page: page, limit: limit));
  }

  @override
  void onStateChanged(BuildContext context, ListeningP3State state) {}

  @override
  Widget buildWidget(
    BuildContext context,
    ListeningP3Bloc bloc,
    ListeningP3State state,
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
        title: const Text("Listening Part 3"),
        backgroundColor: AppColors.primaryColor,
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
    ListeningP3Bloc bloc,
    ListeningP3State state,
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.lightGray, width: 2),
              ),
              child: Column(
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
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          "Topic ${state.currentIndex + 1}: ${question.topic}",
                          style: AppTextStyle.xLargeBlackBold,
                        ),
                      ),
                    ],
                  ),
                  for (final speaker in question.statements) ...[
                    const SizedBox(height: 16),
                    _buildStatementDropdown(
                      context,
                      bloc,
                      state,
                      questionIndex: state.currentIndex,
                      statement: speaker,
                    ),
                  ],
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
                letterSpacing: 2,
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
                child: Text(
                  question.transcript,
                  style: AppTextStyle.largeBlack,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Widget _buildStatementDropdown(
  BuildContext context,
  ListeningP3Bloc bloc,
  ListeningP3State state, {
  required int questionIndex,
  required ListeningP3StatementEntity statement,
}) {
  final selected = state.selectedAnswers[questionIndex]?[statement.id];
  final isChecked = state.checkedQuestions.contains(questionIndex);
  final checkResult = state.checkedAnswers[questionIndex]?[statement.id];

  final items = ["B", "M", "W"];
  final labels = {"B": "Both", "M": "Man", "W": "Woman"};

  Color borderColor = AppColors.gray;
  if (isChecked) {
    if (checkResult == null) {
      borderColor = Colors.red;
    } else if (checkResult == true) {
      borderColor = Colors.green;
    } else {
      borderColor = Colors.red;
    }
  }

  return Row(
    children: [
      Expanded(
        child: Text(
          "${statement.id}. ${statement.text}",
          style: AppTextStyle.largeBlack,
        ),
      ),
      const SizedBox(width: 4),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.31,
        child: CustomDropdown<String>(
          key: ValueKey("${questionIndex}_${statement.id}_${selected ?? ''}"),
          hintText: "",
          items: items.map((e) => labels[e]!).toList(),
          initialItem: selected == null ? null : labels[selected],
          excludeSelected: false,
          onChanged: (value) {
            final code =
                labels.entries
                    .firstWhere((entry) => entry.value == value)
                    .key; // convert label -> code
            bloc.add(AnswerSelected(questionIndex, statement.id, code));
          },
          decoration: CustomDropdownDecoration(
            closedFillColor: AppColors.white,
            expandedFillColor: AppColors.white,
            closedBorder: Border.all(color: borderColor, width: 3),
            expandedBorder: Border.all(color: AppColors.gray, width: 2),
          ),
          headerBuilder: (context, selectedItem, enabled) {
            return Text(selectedItem, style: AppTextStyle.largeBlack);
          },
        ),
      ),
    ],
  );
}
