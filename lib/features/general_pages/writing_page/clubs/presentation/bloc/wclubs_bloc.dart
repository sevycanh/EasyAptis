import 'dart:async';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/entities/wclubs_entity.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/usecases/get_wclubs_list.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/presentation/bloc/wclubs_event.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/presentation/bloc/wclubs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easyaptis/core/utils/base/base_bloc.dart';

class WClubsBloc extends BaseBloc<WClubsEvent, WClubsState> {
  final GetWClubsList getClubsList;

  List<WClubsEntity> _allClubs = [];

  WClubsBloc({required this.getClubsList}) : super(WClubsState()) {
    on<LoadClubs>(_onLoadClubs);
    on<SearchClubs>(_onSearchClubs);
  }

  Future<void> _onLoadClubs(LoadClubs event, Emitter<WClubsState> emit) async {
    emit(state.copyWith(isLoading: true, error: ""));
    final result = await getClubsList(
      Params(page: event.page, limit: event.limit),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (clubs) {
        _allClubs = clubs;
        emit(state.copyWith(isLoading: false, clubs: clubs));
      },
    );
  }

  void _onSearchClubs(SearchClubs event, Emitter<WClubsState> emit) {
    if (event.keyword.isEmpty) {
      emit(state.copyWith(clubs: _allClubs));
    } else {
      final filtered = _allClubs
          .where((club) =>
              club.name.toLowerCase().contains(event.keyword.toLowerCase()) ||
              club.description.toLowerCase().contains(event.keyword.toLowerCase()))
          .toList();
      emit(state.copyWith(clubs: filtered));
    }
  }
}

