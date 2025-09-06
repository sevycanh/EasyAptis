import 'package:easyaptis/core/router/app_route_enum.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/widgets/app_button.dart';
import 'package:flutter/material.dart';

class ListeningPage extends StatelessWidget {
  const ListeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listening'),
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
                  Navigator.pushNamed(context, AppRouteEnum.listeningP1Page.name);
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Part 2 & 3",
                color: AppColors.orange,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   AppRouteEnum.ListeningP2vs3Page.name,
                  // );
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Part 4",
                color: AppColors.purple,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, AppRouteEnum.ListeningP4Page.name);
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Part 5",
                color: AppColors.green,
                textStyle: AppTextStyle.largeWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, AppRouteEnum.ListeningP5Page.name);
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
