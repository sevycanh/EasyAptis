import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/utils/widgets/app_button.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/presentation/bloc/reading_p4_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/presentation/bloc/reading_p4_event.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/presentation/bloc/reading_p4_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';

class ReadingP4Page
    extends BaseBlocWidget<ReadingP4Event, ReadingP4State, ReadingP4Bloc> {
  ReadingP4Page({super.key, this.page, this.limit})
    : super(sl<ReadingP4Bloc>());

  final int? page;
  final int? limit;

  @override
  void onInit() {
    super.onInit();
    bloc.add(LoadQuestions(page: page, limit: limit));
  }

  @override
  void onStateChanged(BuildContext context, ReadingP4State state) {}

  @override
  Widget buildWidget(
    BuildContext context,
    ReadingP4Bloc bloc,
    ReadingP4State state,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Reading Part 4"),
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Center(child: Text("Có lỗi xảy ra!")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reading Part 4"),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body:
          state.listQuestion.isEmpty
              ? const Center(child: Text("Chưa có dữ liệu"))
              : Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Topic ${state.currentIndex + 1}: ${state.listQuestion[state.currentIndex].topic}",
                          style: AppTextStyle.xLargeBlackBold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...state.listQuestion[state.currentIndex].speakers.map((
                        speaker,
                      ) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gray,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ExpansionTile(
                            collapsedBackgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: Text(
                              "Person ${speaker.id}",
                              style: AppTextStyle.largeBlackBold,
                            ),
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    speaker.text,
                                    textAlign: TextAlign.left,
                                    style: AppTextStyle.mediumBlack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      ...state.listQuestion[state.currentIndex].questions.map((
                        q,
                      ) {
                        final selectedId =
                            state.selectedAnswers[state.currentIndex]?[q.id] ??
                            "";

                        final items = [
                          // "",
                          ...state.listQuestion[state.currentIndex].speakers
                              .map((s) => "Person ${s.id}"),
                        ];

                        final String? selectedLabel =
                            selectedId.isEmpty ? null : "Person $selectedId";

                        final bool? isCorrect =
                            state.checkResults[state.currentIndex]?[q.id];

                        String labelToId(String? label) {
                          if (label == null || label.trim().isEmpty) return "";
                          final parts = label.trim().split(' ');
                          return parts.isNotEmpty ? parts.last : label;
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${q.id}. ${q.question}",
                                style: AppTextStyle.largeBlackBold,
                              ),
                              const SizedBox(height: 8),
                              CustomDropdown<String>(
                                hintText: "Chọn người phù hợp",
                                items: items,
                                initialItem: selectedLabel,
                                excludeSelected: false,
                                maxlines: 3,
                                onChanged: (value) {
                                  final id = labelToId(value);
                                  bloc.add(AnswerSelected(q.id, id));
                                },
                                decoration: CustomDropdownDecoration(
                                  closedFillColor: AppColors.white,
                                  expandedFillColor: AppColors.white,
                                  closedBorder: Border.all(
                                    color:
                                        isCorrect == null
                                            ? AppColors.gray
                                            : (isCorrect
                                                ? AppColors.green
                                                : AppColors.red),
                                    width: 3,
                                  ),
                                  expandedBorder: Border.all(
                                    color: AppColors.gray,
                                    width: 2,
                                  ),
                                  listItemDecoration: ListItemDecoration(
                                    selectedColor: AppColors.lightGray,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
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
