import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/widgets/app_select_bottom_sheet.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_event.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_state.dart';
import 'package:flutter/material.dart';

Future<void> showTopicSelector(
  BuildContext context,
  ReadingP2vs3Bloc bloc,
  ReadingP2vs3State state,
) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return AppSelectorBottomSheet(
        title: "All Topics",
        items: List.generate(
          state.listQuestion.length,
          (index) => AppSelectorItem(
            title: "Topic ${index + 1}: ${state.listQuestion[index].questionText}",
            isSelected: index == state.currentIndex,
          ),
        ),
        onItemSelected: (index) {
          bloc.add(JumpToQuestion(index));
        },
      );
    },
  );
}
