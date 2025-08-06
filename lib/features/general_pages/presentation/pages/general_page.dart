import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:EasyAptis/core/configs/assets/app_image.dart';
import 'package:EasyAptis/core/styles/app_colors.dart';
import 'package:EasyAptis/core/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class GeneralPage extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {"name": "Reading", "image": AppImages.readingLogo, "color": AppColors.red},
    {
      "name": "Listening",
      "image": AppImages.listeningLogo,
      "color": AppColors.secondaryColor,
    },
    {
      "name": "Speaking",
      "image": AppImages.speakingLogo,
      "color": AppColors.linkColor,
    },
    {
      "name": "Writing",
      "image": AppImages.writingLogo,
      "color": AppColors.green,
    },
    {
      "name": "Grammar & Vocabulary",
      "image": AppImages.grammarLogo,
      "color": AppColors.purple,
    },
    {"name": "Tip", "image": AppImages.tipLogo, "color": AppColors.cyan},
    {
      "name": "Introduce",
      "image": AppImages.infoLogo,
      "color": AppColors.darkGray,
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
              'EasyAptis xin chào!',
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
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 0,
          bottom: 20,
        ),
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
                    // Xử lý khi nhấn vào card
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
