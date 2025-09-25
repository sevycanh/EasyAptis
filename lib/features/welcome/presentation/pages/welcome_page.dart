import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/configs/assets/app_image.dart';
import 'package:easyaptis/core/router/app_route_enum.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/widgets/app_button.dart';
import 'package:easyaptis/features/welcome/presentation/bloc/welcome_bloc.dart';
import 'package:easyaptis/features/welcome/presentation/bloc/welcome_event.dart';
import 'package:easyaptis/features/welcome/presentation/bloc/welcome_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage
    extends BaseBlocWidget<WelcomeEvent, WelcomeState, WelcomeBloc> {
  late final PageController pageController;

  WelcomePage({super.key}) : super(sl<WelcomeBloc>());

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  @override
  void onStateChanged(BuildContext context, WelcomeState state) {
    if (pageController.hasClients &&
        pageController.page?.round() != state.page) {
      pageController.animateToPage(
        state.page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    if (state.isCompleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRouteEnum.homePage.name, (_) => false);
      });
    }
  }

  @override
  void onDispose() {
    pageController.dispose();
    super.onDispose();
  }

  @override
  Widget buildWidget(
    BuildContext context,
    WelcomeBloc bloc,
    WelcomeState state,
  ) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              // physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                bloc.add(PageChangedEvent(index));
              },
              children: [
                _page(
                  context,
                  "Chào mừng bạn đến với Easyaptis",
                  "Ứng dụng luyện thi Aptis General hoàn toàn miễn phí, mọi lúc, mọi nơi, hỗ trợ bạn chuẩn bị tốt nhất cho kỳ thi!",
                  AppImages.logoMain,
                ),
                _page(
                  context,
                  "Easyaptis phù hợp với ai?",
                  "Ứng dụng phù hợp hơn cho các bạn muốn đạt mục tiêu B1, B2 trong thời gian ngắn. \n Đối với các bạn có mục tiêu C1 thì cần phải tự luyện tập nhiều hơn nhé.",
                  AppImages.welcome2,
                ),
                _page(
                  context,
                  "Điều cuối cùng!",
                  "Để duy trì ứng dụng, một số quảng cáo sẽ được hiển thị nhưng sẽ không ảnh hưởng nhiều đến trải nghiệm của các bạn, rất mong các bạn thông cảm. \n Cuối cùng, nếu các bạn thấy easyaptis hữu ích thì hãy dành ít thời gian đánh giá tốt cho mình nhé <3",
                  AppImages.welcome3,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 15,
                    dotWidth: 15,
                    spacing: 8,
                    activeDotColor: AppColors.primaryColor,
                    dotColor: AppColors.gray,
                    type: WormType.thin,
                  ),
                ),
                const SizedBox(height: 16),
                AppButton(
                  text: state.page == 2 ? 'Bắt đầu' : 'Tiếp tục',
                  onPressed: () {
                    bloc.add(NextPageEvent());
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _page(
    BuildContext context,
    String title,
    String subTitle,
    String imagePath,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset(imagePath),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.xxxLargeBlackBold, // TextStyle
                ),
                const SizedBox(height: 16),
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.largeBlack,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
