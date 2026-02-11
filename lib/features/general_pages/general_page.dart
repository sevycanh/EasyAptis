import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easyaptis/core/configs/assets/app_image.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/router/app_route_enum.dart';
import 'package:easyaptis/features/general_pages/infomation/infomation_page.dart';
import 'package:easyaptis/shared/notification/presentation/bloc/notification_bloc.dart';
import 'package:easyaptis/shared/notification/presentation/bloc/notification_event.dart';
import 'package:easyaptis/shared/notification/presentation/bloc/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      "route": AppRouteEnum.grammarPage.name,
      "arguments": {"title": "Grammar", "startPage": 1, "endPage": 8},
    },
    {
      "name": "Vocabulary",
      "image": AppImages.vocabularyLogo,
      "color": AppColors.pink,
      "route": AppRouteEnum.vocabularyPage.name,
      "arguments": {"title": "Vocabulary", "startPage": 9, "endPage": 16},
    },
    // {
    //   "name": "Tips",
    //   "image": AppImages.tipLogo,
    //   "color": AppColors.cyan,
    //   "route": AppRouteEnum.tipPage.name,
    //   "arguments": {"title": "Tips", "startPage": 3, "endPage": 4},
    // },
    {
      "name": "Information",
      "image": AppImages.infoLogo,
      "color": AppColors.darkGray,
      "route": AppRouteEnum.infoPage.name,
      "arguments": {"title": "Information", "startPage": 1, "endPage": 4},
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
              centerTitle: false,
              backgroundColor: AppColors.primaryColor,
              expandedHeight: MediaQuery.of(context).size.height * 0.1,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 12),
                title: TickerMode(
                  enabled: !innerBoxIsScrolled,
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'EasyAptis chào bạn <3',
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
          child: Column(
            children: [
              BlocBuilder<NotificationBloc, NotificationState>(
                buildWhen: (previous, current) =>
                    previous.latestBody != current.latestBody,
                builder: (context, state) {
                  final body = state.latestBody;
                  if (body == null || body.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 12, right: 12, top: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber, width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "📢 Thông báo: $body",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.read<NotificationBloc>().add(
                            ClearNotification(),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.close_rounded,
                              color: AppColors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(16),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: items.map((item) {
                    return Card(
                      color: item['color'],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 10,
                      child: InkWell(
                        onTap: () {
                          if (item['route'] == AppRouteEnum.infoPage.name) {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                              builder: (_) => const InformationBottomSheet(),
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              item['route'],
                              arguments: item['arguments'],
                            );
                          }
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
            ],
          ),
        ),
      ),
    );
  }
}
