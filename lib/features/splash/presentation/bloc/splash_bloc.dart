import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/splash/domain/usecase/check_first_lauch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart'; 

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  final CheckFirstLaunch checkFirstLaunchUseCase;

  SplashBloc({ required this.checkFirstLaunchUseCase})
    : super(SplashState()) {
    on<CheckWelcomeSeenEvent>(_onCheckWelcomeSeen);
  }


  Future<void> _onCheckWelcomeSeen(
    CheckWelcomeSeenEvent event,
    Emitter<SplashState> emit,
  ) async {
    final result = await checkFirstLaunchUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(isWelcomeSeen: false)),
      (seen) => emit(state.copyWith(isWelcomeSeen: seen)),
    );
  }
}
