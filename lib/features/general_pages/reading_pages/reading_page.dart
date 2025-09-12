import 'package:easyaptis/core/router/app_route_enum.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/widgets/app_button.dart';
import 'package:flutter/material.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppButton(
                text: "Part 1 (Question 1)",
                color: AppColors.blue,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRouteEnum.readingP1Page.name);
                  // showR1QuestionOptionSheet(context, (selected) {
                  //   if (selected == "all") {
                  //     Navigator.pushNamed(
                  //       context,
                  //       AppRouteEnum.readingP1Page.name,
                  //     );
                  //   } else if (selected == "1") {
                  //     Navigator.pushNamed(
                  //       context,
                  //       AppRouteEnum.readingP1Page.name,
                  //       arguments: {"page": 1, "limit": 50},
                  //     );
                  //   } else if (selected == "2") {
                  //     Navigator.pushNamed(
                  //       context,
                  //       AppRouteEnum.readingP1Page.name,
                  //       arguments: {"page": 2, "limit": 50},
                  //     );
                  //   } else if (selected == "3") {
                  //     Navigator.pushNamed(
                  //       context,
                  //       AppRouteEnum.readingP1Page.name,
                  //       arguments: {"page": 3},
                  //     );
                  //   }
                  // });
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Part 2 & 3 (Question 2 -> 3)",
                color: AppColors.orange,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouteEnum.readingP2vs3Page.name,
                  );
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Part 4 (Question 4)",
                color: AppColors.purple,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRouteEnum.readingP4Page.name);
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Part 5 (Question 5)",
                color: AppColors.green,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRouteEnum.readingP5Page.name);
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Tips",
                color: AppColors.gray,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// Future<void> showR1QuestionOptionSheet(
//   BuildContext context,
//   Function(String) onSelected,
// ) async {
//   await showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     backgroundColor: AppColors.white,
//     builder: (ctx) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               "Chọn số lượng câu hỏi",
//               style: AppTextStyle.xLargeBlackBold,
//             ),
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.all_inclusive,
//               color: AppColors.secondaryColor,
//             ),
//             title: const Text("Tất cả câu hỏi"),
//             onTap: () {
//               Navigator.pop(ctx);
//               onSelected("all");
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.filter_1,
//               color: AppColors.secondaryColor,
//             ),
//             title: const Text("Chia nhỏ 1 (50 câu)"),
//             onTap: () {
//               Navigator.pop(ctx);
//               onSelected("1");
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.filter_2,
//               color: AppColors.secondaryColor,
//             ),
//             title: const Text("Chia nhỏ 2 (50 câu)"),
//             onTap: () {
//               Navigator.pop(ctx);
//               onSelected("2");
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.filter_3,
//               color: AppColors.secondaryColor,
//             ),
//             title: const Text("Chia nhỏ 3 (còn lại)"),
//             onTap: () {
//               Navigator.pop(ctx);
//               onSelected("3");
//             },
//           ),
//           const SizedBox(height: 12),
//         ],
//       );
//     },
//   );
// }
