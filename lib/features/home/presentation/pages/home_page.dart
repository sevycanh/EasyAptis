import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/features/home/presentation/bloc/home_bloc.dart';
import 'package:easyaptis/features/home/presentation/bloc/home_event.dart';
import 'package:easyaptis/features/home/presentation/bloc/home_state.dart';
import 'package:easyaptis/features/home/presentation/widgets/home_widgets.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends BaseBlocWidget<HomeEvent, HomeState, HomeBloc> {
  HomePage({super.key}) : super(sl<HomeBloc>());

  @override
  Widget buildWidget(BuildContext context, HomeBloc bloc, HomeState state) {
    return Scaffold(
      body: buildPage(state.currentTab),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGray,
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          currentIndex: state.currentTab,
          onTap: (index) => bloc.add(ChangeTabEvent(index)),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: bottomTabs,
        ),
      ),
    );
  }
}
