import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/widgets/app_button.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/entities/reading_p5_entity.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/presentation/bloc/reading_p5_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/presentation/bloc/reading_p5_event.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/presentation/bloc/reading_p5_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';

class ReadingP5Page
    extends BaseBlocWidget<ReadingP5Event, ReadingP5State, ReadingP5Bloc> {
  ReadingP5Page({super.key, this.page, this.limit})
    : super(sl<ReadingP5Bloc>());

  final int? page;
  final int? limit;

  @override
  void onInit() {
    super.onInit();
    bloc.add(LoadQuestions(page: page, limit: limit));
  }

  @override
  void onStateChanged(BuildContext context, ReadingP5State state) {}

  @override
  Widget buildWidget(
    BuildContext context,
    ReadingP5Bloc bloc,
    ReadingP5State state,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error.isNotEmpty) {
      return Center(child: Text(state.error));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reading Part 5"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
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
                      ...state.listQuestion[state.currentIndex].paragraphs.map((
                        p,
                      ) {
                        final headers =
                            state.listQuestion[state.currentIndex].headers;

                        final items = headers.map((h) => h.text).toList();

                        final selectedId =
                            state.selectedAnswers[state.currentIndex]?[p.id];

                        final String? selectedLabel =
                            selectedId == null
                                ? null
                                : headers
                                    .firstWhere((h) => h.id == selectedId)
                                    .text;

                        final bool? isCorrect =
                            state.checkResults[state.currentIndex]?[p.id];

                        int? labelToId(String? label) {
                          if (label == null) return null;
                          return headers
                              .firstWhere(
                                (h) => h.text == label,
                                orElse:
                                    () => const ReadingP5HeaderEntity(
                                      id: -1,
                                      text: "",
                                    ),
                              )
                              .id;
                        }

                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
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
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ExpansionTile(
                                collapsedBackgroundColor:
                                    AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: Text(
                                  "Đoạn ${p.id}",
                                  style: AppTextStyle.largeBlackBold,
                                ),
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        p.content,
                                        textAlign: TextAlign.left,
                                        style: AppTextStyle.mediumBlack,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                                bottom: 12,
                              ),
                              child: CustomDropdown<String>(
                                hintText: "Chọn tiêu đề cho đoạn ${p.id}",
                                items: items,
                                initialItem: selectedLabel,
                                excludeSelected: false,
                                onChanged: (value) {
                                  final id = labelToId(value);
                                  if (id != null && id != -1) {
                                    bloc.add(AnswerSelected(p.id, id));
                                  }
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
                            ),
                          ],
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
