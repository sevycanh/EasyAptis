import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easyaptis/core/configs/assets/app_image.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/router/app_route_enum.dart';
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
      "name": "Grammar",
      "image": AppImages.grammarLogo,
      "color": AppColors.purple,
      "route": AppRouteEnum.grammarAndVocabularyPage.name,
    },
    {
      "name": "Vocabulary",
      "image": AppImages.vocabularyLogo,
      "color": AppColors.pink,
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
      backgroundColor: AppColors.primaryColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: AppColors.primaryColor, 
              expandedHeight: MediaQuery.of(context).size.height * 0.1, 
              pinned: true, 
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 12),
                title: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Easyaptis chào bạn!',
                      textStyle: AppTextStyle.largeBlackBold,
                      speed: const Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'Chúc bạn thành công!',
                      textStyle: AppTextStyle.largeBlackBold,
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: GridView.count(
            padding: const EdgeInsets.all(16),
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
        ),
      ),
    );
  }
}
