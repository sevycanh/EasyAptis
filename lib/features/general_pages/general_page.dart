import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easyaptis/core/configs/assets/app_image.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/configs/router/app_route_enum.dart';
import 'package:flutter/material.dart';

class GeneralPage extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      "name": "Reading",
      "image": AppImages.readingLogo,
      "color": AppColors.red,
      "route": AppRouteEnum.readingPage.name,
    },
    {
      "name": "Listening",
      "image": AppImages.listeningLogo,
      "color": AppColors.secondaryColor,
      "route": AppRouteEnum.listeningPage.name,
    },
    {
      "name": "Speaking",
      "image": AppImages.speakingLogo,
      "color": AppColors.linkColor,
      "route": AppRouteEnum.speakingPage.name,
    },
    {
      "name": "Writing",
      "image": AppImages.writingLogo,
      "color": AppColors.green,
      "route": AppRouteEnum.writingPage.name,
    },
    {
      "name": "Grammar & Vocabulary",
      "image": AppImages.grammarLogo,
      "color": AppColors.purple,
      "route": AppRouteEnum.grammarAndVocabularyPage.name,
    },
    {
      "name": "Tips",
      "image": AppImages.tipLogo,
      "color": AppColors.cyan,
      "route": AppRouteEnum.tipPage.name,
    },
    {
      "name": "Introduce",
      "image": AppImages.infoLogo,
      "color": AppColors.darkGray,
      "route": AppRouteEnum.infoPage.name,
    },
  ];

  GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText(
              'Easyaptis chào bạn!',
              textStyle: AppTextStyle.xxxLargeBlackBold,
              speed: const Duration(milliseconds: 100),
            ),
            TypewriterAnimatedText(
              'Chúc bạn sớm đạt mục tiêu!',
              textStyle: AppTextStyle.xxLargeBlackBold,
              speed: const Duration(milliseconds: 100),
            ),
          ],
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 20),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children:
            items.map((item) {
              return Card(
                color: item['color'],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 10,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, item['route']);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(item['image']),
                        const SizedBox(height: 12),
                        Text(
                          item['name'],
                          textAlign: TextAlign.center,
                          style: AppTextStyle.xxxLargeWhiteBold,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
