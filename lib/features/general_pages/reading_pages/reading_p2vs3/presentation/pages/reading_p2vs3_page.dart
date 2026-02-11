import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/widgets/app_button.dart';
import 'package:easyaptis/core/widgets/app_loading.dart';
import 'package:easyaptis/core/widgets/app_toast.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_event.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_state.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/widgets/show_topic_selector.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReadingP2vs3Page
    extends
        BaseBlocWidget<ReadingP2vs3Event, ReadingP2vs3State, ReadingP2vs3Bloc> {
  ReadingP2vs3Page({super.key, this.page, this.limit})
    : super(sl<ReadingP2vs3Bloc>());

  final int? page;
  final int? limit;

  @override
  void onInit() {
    super.onInit();
    bloc.add(LoadQuestions(page: page, limit: limit));
  }

  @override
  void onStateChanged(BuildContext context, ReadingP2vs3State state) {}

  @override
  Widget buildWidget(
    BuildContext context,
    ReadingP2vs3Bloc bloc,
    ReadingP2vs3State state,
  ) {
    if (state.isLoading) {
      return AppLoading();
    }

    if (state.error.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Reading Part 2 & 3"),
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
        title: const Text("Reading Part 2 & 3"),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt_rounded),
            tooltip: "Chọn Topic",
            onPressed: () => showTopicSelector(context, bloc, state),
          ),
        ],
      ),

      body: state.listQuestion.isEmpty
          ? const Center(child: Text("Không có câu hỏi nào được tìm thấy"))
          : Column(
              children: [
                SizedBox(height: 16),
                SelectableText(
                  "Topic ${state.currentIndex + 1}: ${state.listQuestion[state.currentIndex].questionText}",
                  style: AppTextStyle.xLargeBlackBold,
                ),
                Expanded(
                  child: ReorderableListView.builder(
                    padding: const EdgeInsets.all(16),
                    buildDefaultDragHandles: false,
                    itemCount: state.currentOrder.length,
                    onReorder: (oldIndex, newIndex) =>
                        bloc.add(ReorderOption(oldIndex, newIndex)),
                    proxyDecorator: (child, index, animation) {
                      return Material(
                        color: AppColors.transparent,
                        child: child,
                      );
                    },
                    itemBuilder: (context, index) {
                      final option = state.currentOrder[index];
                      Color borderColor = AppColors.lightGray;

                      if (state.answersStatusMap.containsKey(
                        state.currentIndex,
                      )) {
                        final statusMap =
                            state.answersStatusMap[state.currentIndex]!;
                        borderColor = statusMap[option.id.toString()] == true
                            ? Colors.green
                            : Colors.red;
                      }

                      return ReorderableDragStartListener(
                        index: index,
                        key: ValueKey(option.id),
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: borderColor, width: 3),
                          ),
                          color: AppColors.white,
                          child: ListTile(
                            leading: InkWell(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(text: option.text),
                                );
                                AppToast.showSuccess(
                                  context,
                                  message: "Đã sao chép",
                                );
                              },
                              child: Icon(Icons.copy, color: AppColors.black),
                            ),
                            title: Text(
                              option.text,
                              style: AppTextStyle.largeBlack,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
                  text: "Back",
                  color: AppColors.pastel,
                  textStyle: state.currentIndex == 0
                      ? AppTextStyle.largeBlack.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGray,
                          letterSpacing: 1,
                        )
                      : AppTextStyle.largeBlack.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
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
                  fixWidth: true,
                  textStyle: state.currentIndex == state.listQuestion.length - 1
                      ? AppTextStyle.largeBlack.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGray,
                          letterSpacing: 1,
                        )
                      : AppTextStyle.largeBlack.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
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
}
