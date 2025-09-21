import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType {
  success,
  error,
}

class AppToast {
  static void show(
    BuildContext context, 
    String message,
    ToastType type, {
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color textColor = Colors.white,
    double fontSize = 16.0,
  }) {
    Color backgroundColor;
    String displayMessage;

    switch (type) {
      case ToastType.success:
        backgroundColor = const Color(0xFF67C23A);
        displayMessage = message.isNotEmpty ? message : "Thành công";
        break;
      case ToastType.error:
        backgroundColor = const Color(0xFFFF0000);
        displayMessage = message.isNotEmpty ? message : "Có lỗi xảy ra!";
        break;
    }

    Fluttertoast.showToast(
      msg: displayMessage,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  static void showSuccess(BuildContext context, {String message = "Thành công"}) {
    show(context, message, ToastType.success);
  }

  static void showError(BuildContext context, {String message = "Có lỗi xảy ra!"}) {
    show(context, message, ToastType.error);
  }
}