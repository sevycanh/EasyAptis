import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/router/app_route_enum.dart';
import 'package:easyaptis/core/utils/base/base_bloc_widget.dart';
import 'package:easyaptis/core/utils/widgets/app_button.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/presentation/bloc/wclubs_bloc.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/presentation/bloc/wclubs_event.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/presentation/bloc/wclubs_state.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/presentation/widgets/clubs_search_delegate.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:flutter/material.dart';

class WClubsPage extends BaseBlocWidget<WClubsEvent, WClubsState, WClubsBloc> {
  WClubsPage({super.key, this.page, this.limit}) : super(sl<WClubsBloc>());

  final int? page;
  final int? limit;

  final List<Color> _colors = const [
    AppColors.blue,
    AppColors.orange,
    AppColors.purple,
    AppColors.green,
    AppColors.gray,
  ];

  @override
  void onInit() {
    super.onInit();
    bloc.add(LoadClubs(page: page, limit: limit));
  }

  @override
  void onStateChanged(BuildContext context, WClubsState state) {}

  @override
  Widget buildWidget(BuildContext context, WClubsBloc bloc, WClubsState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    Widget body;
    if (state.error.isNotEmpty) {
      body = Center(child: Text("Có lỗi xảy ra!"));
    } else if (state.clubs.isEmpty) {
      body = const Center(child: Text("Chưa có dữ liệu"));
    } else {
      body = _buildBody(context, bloc, state);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("List of clubs"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ClubsSearchDelegate(bloc));
            },
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: body,
    );
  }

  Widget _buildBody(BuildContext context, WClubsBloc bloc, WClubsState state) {
    return ListView.builder(
      itemCount: state.clubs.length,
      itemBuilder: (context, index) {
        final club = state.clubs[index];
        final color = _colors[index % _colors.length];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AppButton(
            text: club.name,
            color: color,
            textStyle: AppTextStyle.largeWhite.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRouteEnum.writingClubDetailsPage.name,
                arguments: {"clubId": club.index},
              );
            },
          ),
        );
      },
    );
  }
}
