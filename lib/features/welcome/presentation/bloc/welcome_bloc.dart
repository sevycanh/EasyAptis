import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/welcome/domain/usecases/set_not_first_lauch.dart';
import 'package:easyaptis/features/welcome/presentation/bloc/welcome_event.dart';
import 'package:easyaptis/features/welcome/presentation/bloc/welcome_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeBloc extends BaseBloc<WelcomeEvent, WelcomeState> {
  final SetNotFirstLaunch setNotFirstLaunchUseCase;
  WelcomeBloc({required this.setNotFirstLaunchUseCase})
    : super(WelcomeState()) {
    on<PageChangedEvent>(_onPageChanged);
    on<NextPageEvent>(_onNextPage);
  }

  void _onPageChanged(PageChangedEvent event, Emitter<WelcomeState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _onNextPage(NextPageEvent event, Emitter<WelcomeState> emit) {
    final nextPage = state.page + 1;
    if (nextPage < 3) {
      emit(state.copyWith(page: nextPage));
    } else {
      setNotFirstLaunchUseCase(NoParams());
      emit(state.copyWith(isCompleted: true));
    }
  }
}
