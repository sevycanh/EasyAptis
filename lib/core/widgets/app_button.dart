import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final bool fixWidth;
  final double borderRadius;
  final Color color;
  final TextStyle? textStyle;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.height = 48,
    this.fixWidth = false,
    this.borderRadius = 12,
    this.color = AppColors.primaryColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: fixWidth ? null : double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 4,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style:
              textStyle ??
              AppTextStyle.largeBlack.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              )
        ),
      ),
    );
  }
}
