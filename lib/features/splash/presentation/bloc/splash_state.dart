import 'package:easyaptis/core/utils/base/base_bloc_state.dart';

class SplashState extends BaseBlocState<SplashState> {
  final bool isLoading;
  final bool? isWelcomeSeen;
  final String? error;

  SplashState({
    this.isLoading = false,
    this.isWelcomeSeen,
    this.error,
  });

  @override
  SplashState copyWith({
    bool? isLoading,
    bool? isWelcomeSeen,
    String? error,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      isWelcomeSeen: isWelcomeSeen ?? this.isWelcomeSeen,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isWelcomeSeen, error];
}
