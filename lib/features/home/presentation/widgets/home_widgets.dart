import 'package:easyaptis/core/configs/assets/app_image.dart';
import 'package:easyaptis/features/general_pages/general_page.dart';
import 'package:flutter/material.dart';

Widget buildPage(int index) {
  List widgets = [GeneralPage(), Center(child: Text("Giải đáp"))];
  return widgets[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
    label: "Trang chủ",
    icon: Image(image: AssetImage(AppImages.homeUnselected)),
    activeIcon: Image(image: AssetImage(AppImages.home)),
  ),
  BottomNavigationBarItem(
    label: "Giải đáp",
    icon: Image(image: AssetImage(AppImages.questionUnselected)),
    activeIcon: Image(image: AssetImage(AppImages.question)),
  ),
];
