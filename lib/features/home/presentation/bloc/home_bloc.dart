import 'package:easyaptis/core/base/base_bloc.dart';
import 'package:easyaptis/features/home/presentation/bloc/home_event.dart';
import 'package:easyaptis/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<ChangeTabEvent>(_onChangeTab);
  }

  void _onChangeTab(ChangeTabEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentTab: event.index));
  }
}
