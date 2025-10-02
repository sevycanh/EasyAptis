import 'dart:math';
import 'package:easyaptis/core/configs/assets/app_gif.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  AppLoading({super.key});

  final List<String> gifs = [
    AppGif.logoLoading1,
    AppGif.logoLoading2,
    AppGif.logoLoading3,
  ];

  final List<String> texts = [
    "Bạn có thể xem cách làm bài và mẹo hay tại phần tips",
    "Thường xuyên xem thông báo để không bỏ lỡ các cập nhật mới",
    "Xem thêm cơ bản với EasyAptis",
    "Hãy tự tạo cho mình một phiên bản riêng để luyện tập",
  ];

  @override
  Widget build(BuildContext context) {
    final random = Random().nextInt(gifs.length);
    final gif = gifs[random];

    final randomText = Random().nextInt(texts.length);
    final text = texts[randomText];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              gif,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              text,
              style: AppTextStyle.xLargeBlackBold,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
