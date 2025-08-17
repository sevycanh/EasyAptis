import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/widgets/app_button.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/presentation/bloc/reading_p1_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/presentation/bloc/reading_p1_event.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/presentation/bloc/reading_p1_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';

class ReadingP1Page
    extends BaseBlocWidget<ReadingP1Event, ReadingP1State, ReadingP1Bloc> {
  ReadingP1Page({super.key, this.page, this.limit})
    : super(sl<ReadingP1Bloc>());

  final int? page;
  final int? limit;

  @override
  void onInit() {
    super.onInit();
    bloc.add(GetReadingP1Event(page: page, limit: limit));
  }

  @override
  void onStateChanged(BuildContext context, ReadingP1State state) {}

  @override
  Widget buildWidget(
    BuildContext context,
    ReadingP1Bloc bloc,
    ReadingP1State state,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error.isNotEmpty) {
      return Center(child: Text(state.error));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reading Part 1"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              "${state.correctCount}/${state.listQuestion.length}",
              style: AppTextStyle.largeBlack,
            ),
          ),
        ],
      ),
      body:
          state.listQuestion.isEmpty
              ? const Center(child: Text("Không có câu hỏi nào được tìm thấy"))
              : ListView.builder(
                itemCount: state.listQuestion.length,
                itemBuilder: (context, qIndex) {
                  final question = state.listQuestion[qIndex];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: AppColors.lightGray,
                        width: 2,
                      ),
                    ),
                    elevation: 5,
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${qIndex + 1}. ${question.questionText}",
                            style: AppTextStyle.largeBlackBold,
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: List.generate(question.options.length, (
                              oIndex,
                            ) {
                              final option = question.options[oIndex];
                              final isSelected =
                                  state.selectedAnswers[qIndex] == oIndex;
                              final isSubmitted = state.submitted;

                              Color? textColor;
                              if (isSubmitted) {
                                if (option.isCorrect) {
                                  textColor = AppColors.green;
                                } else if (isSelected && !option.isCorrect) {
                                  textColor = AppColors.red;
                                }
                              }

                              return RadioListTile<int>(
                                value: oIndex,
                                groupValue: state.selectedAnswers[qIndex],
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                activeColor:
                                    isSubmitted
                                        ? (option.isCorrect
                                            ? Colors.green
                                            : Colors.red)
                                        : AppColors.secondaryColor,
                                onChanged: (val) {
                                  if (!isSubmitted) {
                                    bloc.add(SelectAnswerEvent(qIndex, oIndex));
                                  }
                                },
                                title: Text(
                                  option.text,
                                  style: TextStyle(color: textColor),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
              Expanded(
                child: AppButton(
                  text: "Reset",
                  color: AppColors.pastel,
                  onPressed: () => bloc.add(ResetAnswersEvent()),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  text: "Submit",
                  onPressed:
                      state.submitted
                          ? null
                          : () => bloc.add(SubmitAnswersEvent()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
