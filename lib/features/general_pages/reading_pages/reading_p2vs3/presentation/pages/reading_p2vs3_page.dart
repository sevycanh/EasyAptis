import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/widgets/app_button.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_event.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';

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
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error.isNotEmpty) {
      return Center(child: Text(state.error));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reading Part 2 & 3"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body:
          state.listQuestion.isEmpty
              ? const Center(child: Text("Không có câu hỏi nào được tìm thấy"))
              : Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    state.listQuestion[state.currentIndex].questionText,
                    style: AppTextStyle.xLargeBlackBold,
                  ),
                  Expanded(
                    child: ReorderableListView.builder(
                      padding: const EdgeInsets.all(16),
                      buildDefaultDragHandles: false,
                      itemCount: state.currentOrder.length,
                      onReorder:
                          (oldIndex, newIndex) =>
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
                          borderColor =
                              statusMap[option.id.toString()] == true
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
                              leading: const Icon(
                                Icons.drag_handle,
                                color: AppColors.black,
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
