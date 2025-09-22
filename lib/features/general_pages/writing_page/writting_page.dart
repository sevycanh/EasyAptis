import 'package:easyaptis/core/router/app_route_enum.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/widgets/app_button.dart';
import 'package:flutter/material.dart';

class WritingPage extends StatelessWidget {
  const WritingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Writing'),
        backgroundColor: AppColors.primaryColor,
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
                text: "List of clubs",
                color: AppColors.secondaryColor,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouteEnum.writingClubsPage.name,
                  );
                },
              ),
              const SizedBox(height: 16),
              // AppButton(
              //   text: "Part 2 (Question 14)",
              //   color: AppColors.orange,
              //   textStyle: AppTextStyle.largeWhite.copyWith(
              //     fontWeight: FontWeight.bold,
              //     letterSpacing: 1,
              //   ),
              //   onPressed: () {
              //     Navigator.pushNamed(
              //       context,
              //       AppRouteEnum.listeningP2Page.name,
              //     );
              //   },
              // ),
              // const SizedBox(height: 16),
              // AppButton(
              //   text: "Part 3 (Question 15)",
              //   color: AppColors.purple,
              //   textStyle: AppTextStyle.largeWhite.copyWith(
              //     fontWeight: FontWeight.bold,
              //     letterSpacing: 1,
              //   ),
              //   onPressed: () {
              //     Navigator.pushNamed(context, AppRouteEnum.listeningP3Page.name);
              //   },
              // ),
              // const SizedBox(height: 16),
              // AppButton(
              //   text: "Part 4 (Question 16 -> 17)",
              //   color: AppColors.green,
              //   textStyle: AppTextStyle.largeWhite.copyWith(
              //     fontWeight: FontWeight.bold,
              //     letterSpacing: 1,
              //   ),
              //   onPressed: () {
              //     Navigator.pushNamed(context, AppRouteEnum.listeningP4Page.name);
              //   },
              // ),
              // const SizedBox(height: 16),
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
