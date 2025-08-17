import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:easyaptis/core/network/network_info.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/splash/domain/usecase/check_first_lauch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart'; // nơi bạn đặt BaseBloc

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  final NetworkInfo networkInfo;
  final CheckFirstLaunch checkFirstLaunchUseCase;

  SplashBloc({required this.networkInfo, required this.checkFirstLaunchUseCase})
    : super(SplashState()) {
    on<CheckConnectionEvent>(_onCheckConnection);
    on<CheckWelcomeSeenEvent>(_onCheckWelcomeSeen);
  }

  Future<void> _onCheckConnection(
    CheckConnectionEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isConnected: true));

    await Future.delayed(const Duration(seconds: 2));
    final connected = await networkInfo.isConnected;
  
    emit(state.copyWith(isLoading: false, isConnected: connected));
    if (connected) {
      add(CheckWelcomeSeenEvent());
    }
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
