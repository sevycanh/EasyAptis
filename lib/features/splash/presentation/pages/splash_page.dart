import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/router/app_route_enum.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:easyaptis/features/splash/presentation/bloc/splash_event.dart';
import 'package:easyaptis/features/splash/presentation/bloc/splash_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';

class SplashPage extends BaseBlocWidget<SplashEvent, SplashState, SplashBloc> {
  SplashPage({super.key}) : super(sl<SplashBloc>());

  @override
  void onInit() {
    super.onInit();
    bloc.send(CheckWelcomeSeenEvent());
  }

  @override
  void onStateChanged(BuildContext context, SplashState state) {
    if (!state.isLoading &&
        state.isWelcomeSeen != null) {
      if (state.isWelcomeSeen!) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRouteEnum.welcomePage.name, (_) => false);
      } else {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRouteEnum.homePage.name, (_) => false);
      }
    }
  }

  @override
  Widget buildWidget(BuildContext context, SplashBloc bloc, SplashState state) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.primaryColor),
            const SizedBox(height: 24),
            const Text("Checking...", style: AppTextStyle.largeBlack),
          ],
        ),
      ),
    );
  }
}
