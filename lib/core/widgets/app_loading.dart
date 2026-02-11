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
    "Đề không đánh trượt bạn, bạn tự làm điều đó",
    "Thường xuyên để ý thông báo để không bỏ lỡ các cập nhật mới",
    "Tự tin lên, sai thì sửa, rớt thì... thi lại",
    "Đang tải kiến thứ... vui lòng đừng hoảng",
    "Muốn có động lực ôn thi? Hãy đăng ký thi"
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
