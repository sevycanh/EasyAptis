import 'package:EasyAptis/core/styles/app_colors.dart';
import 'package:EasyAptis/core/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double borderRadius;
  final Color color;
  final Color shadowColor;
  final TextStyle? textStyle;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 48,
    this.borderRadius = 12,
    this.color = AppColors.primaryColor,
    this.shadowColor = AppColors.secondaryColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 4,
          shadowColor: shadowColor,
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
