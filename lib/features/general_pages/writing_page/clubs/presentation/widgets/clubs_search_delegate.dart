import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/configs/styles/app_text_style.dart';
import 'package:easyaptis/core/router/app_route_enum.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/presentation/bloc/wclubs_bloc.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/presentation/bloc/wclubs_event.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/presentation/bloc/wclubs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClubsSearchDelegate extends SearchDelegate {
  final WClubsBloc bloc;

  ClubsSearchDelegate(this.bloc)
    : super(
        searchFieldLabel: "Search",
        searchFieldStyle: const TextStyle(fontSize: 18, color: Colors.black),
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor, // nền AppBar
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white, // ✅ nền trắng cho ô search
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)), // bo góc đẹp
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.black, fontSize: 18), // chữ gõ vào
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear, color: AppColors.black),
          onPressed: () {
            query = "";
            bloc.add(SearchClubs("")); // reset
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColors.black),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    bloc.add(SearchClubs(query));
    return _buildClubsList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc.add(SearchClubs(query));
    return _buildClubsList(context);
  }

  Widget _buildClubsList(BuildContext context) {
    return BlocBuilder<WClubsBloc, WClubsState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.clubs.isEmpty) {
          return const Center(child: Text("Không tìm thấy kết quả"));
        }
        return ListView.separated(
          itemCount: state.clubs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final club = state.clubs[index];
            return ListTile(
              title: Text(club.name, style: AppTextStyle.largeBlackBold),
              onTap: () {
                // close(context, club);
                Navigator.pushNamed(
                  context,
                  AppRouteEnum.writingClubDetailsPage.name,
                  arguments: {"clubId": club.index},
                );
              },
            );
          },
        );
      },
    );
  }
}
