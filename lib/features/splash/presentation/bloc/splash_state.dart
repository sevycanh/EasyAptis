import 'package:EasyAptis/core/base/base_bloc_state.dart';

class SplashState extends BaseBlocState<SplashState> {
  final bool isLoading;
  final bool isConnected;
  final bool? isWelcomeSeen;
  final String? error;

  SplashState({
    this.isLoading = false,
    this.isConnected = true,
    this.isWelcomeSeen,
    this.error,
  });

  @override
  SplashState copyWith({
    bool? isLoading,
    bool? isConnected,
    bool? isWelcomeSeen,
    String? error,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      isConnected: isConnected ?? this.isConnected,
      isWelcomeSeen: isWelcomeSeen ?? this.isWelcomeSeen,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isConnected, isWelcomeSeen, error];
}
