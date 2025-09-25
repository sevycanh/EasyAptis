import 'dart:io';

import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/configs/assets/app_image.dart';
import 'package:easyaptis/core/router/app_route_enum.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/widgets/app_button.dart';
import 'package:easyaptis/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:easyaptis/features/splash/presentation/bloc/splash_event.dart';
import 'package:easyaptis/features/splash/presentation/bloc/splash_state.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends BaseBlocWidget<SplashEvent, SplashState, SplashBloc> {
  SplashPage({super.key}) : super(sl<SplashBloc>());

  @override
  void onInit() {
    super.onInit();
    bloc.add(CheckConnectionEvent());
  }

  @override
  void onStateChanged(BuildContext context, SplashState state) {
    if (!state.isConnected) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (_) => AlertDialog(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.all(24),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppImages.noInternet, width: 100, height: 100),
                    const SizedBox(height: 8),
                    Text(
                      "Không có kết nối mạng",
                      style: AppTextStyle.largeBlack.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Vui lòng kiểm tra kết nối internet.",
                      style: AppTextStyle.mediumBlack,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: "Thoát",
                            color: AppColors.lightGray,
                            onPressed: () {
                              if (Platform.isAndroid) {
                                SystemNavigator.pop();
                              } else if (Platform.isIOS) {
                                exit(0);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            text: "Thử lại",
                            color: AppColors.primaryColor,
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.read<SplashBloc>().add(
                                CheckConnectionEvent(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      );
    } else if (!state.isLoading &&
        state.isConnected &&
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
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(
          AppImages.logoMain,
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.width * 0.6,
        ),
      ),
    );
  }
}
