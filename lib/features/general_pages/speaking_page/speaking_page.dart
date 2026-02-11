import 'package:easyaptis/core/router/app_route_enum.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class SpeakingPage extends StatelessWidget {
  const SpeakingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speaking'),
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
                text: "Part 1",
                color: AppColors.blue,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouteEnum.speakingP1Page.name,
                  );
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Part 2",
                color: AppColors.orange,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouteEnum.speakingP2Page.name,
                  );
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Part 3",
                color: AppColors.purple,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouteEnum.speakingP3Page.name,
                  );
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Part 4",
                color: AppColors.green,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouteEnum.speakingP4Page.name,
                  );
                },
              ),
              const SizedBox(height: 16),
              // AppButton(
              //   text: "Tips",
              //   color: AppColors.gray,
              //   textStyle: AppTextStyle.largeWhite.copyWith(
              //     fontWeight: FontWeight.bold,
              //     letterSpacing: 1,
              //   ),
              //   onPressed: () {},
              // ),
              // const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
