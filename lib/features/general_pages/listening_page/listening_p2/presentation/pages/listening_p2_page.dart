import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/utils/widgets/app_button.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/domain/entities/listening_p2_entity.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/presentation/bloc/listening_p2_bloc.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/presentation/bloc/listening_p2_event.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/presentation/bloc/listening_p2_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';

class ListeningP2Page
    extends
        BaseBlocWidget<ListeningP2Event, ListeningP2State, ListeningP2Bloc> {
  ListeningP2Page({super.key, this.page, this.limit})
    : super(sl<ListeningP2Bloc>());

  final int? page;
  final int? limit;

  @override
  void onInit() {
    super.onInit();
    bloc.add(LoadQuestions(page: page, limit: limit));
  }

  @override
  void onStateChanged(BuildContext context, ListeningP2State state) {}

  @override
  Widget buildWidget(
    BuildContext context,
    ListeningP2Bloc bloc,
    ListeningP2State state,
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
        title: const Text("Listening Part 2"),
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
}

Widget _buildBody(
  BuildContext context,
  ListeningP2Bloc bloc,
  ListeningP2State state,
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
                for (final speaker in question.speakers) ...[
                  const SizedBox(height: 16),
                  _buildSpeakerDropdown(
                    context,
                    bloc,
                    state,
                    questionIndex: state.currentIndex,
                    speaker: speaker.speaker,
                    options: question.options,
                    correctOption: speaker.correctOption,
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
              child: Text(question.transcript, style: AppTextStyle.largeBlack),
            ),
          ],
        ],
      ),
    ),
  );
}

Widget _buildSpeakerDropdown(
  BuildContext context,
  ListeningP2Bloc bloc,
  ListeningP2State state, {
  required int questionIndex,
  required int speaker,
  required List<ListeningP2OptionEntity> options,
  required int correctOption,
}) {
  final selected = state.selectedAnswers[questionIndex]?[speaker];
  final isChecked = state.checkedQuestions.contains(questionIndex);
  final checkResult = state.checkedAnswers[questionIndex]?[speaker];

  final items = options.map((opt) => opt.text).toList();

  final String? selectedLabel =
      selected == null
          ? null
          : options.firstWhere((o) => o.index == selected).text;

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

  int? labelToId(String? label) {
    if (label == null) return null;
    return options
        .firstWhere(
          (o) => o.text == label,
          orElse: () => ListeningP2OptionEntity(index: -1, text: ""),
        )
        .index;
  }

  return CustomDropdown<String>(
    hintText: "Person $speaker - Chọn đáp án",
    items: items,
    initialItem: selectedLabel,
    excludeSelected: false,
    maxlines: 3,
    onChanged: (value) {
      final id = labelToId(value);
      if (id != null && id != -1) {
        bloc.add(AnswerSelected(questionIndex, speaker, id));
      }
    },
    decoration: CustomDropdownDecoration(
      closedFillColor: AppColors.white,
      expandedFillColor: AppColors.white,
      closedBorder: Border.all(color: borderColor, width: 3),
      expandedBorder: Border.all(color: AppColors.gray, width: 2),
      listItemDecoration: ListItemDecoration(
        selectedColor: AppColors.lightGray,
      ),
    ),
    headerBuilder: (context, selectedItem, enabled) {
      return Text("$speaker: $selectedItem", style: AppTextStyle.largeBlack);
    },
  );
}
