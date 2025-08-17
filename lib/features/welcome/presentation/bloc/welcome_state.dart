import 'package:easyaptis/core/utils/base/base_bloc_state.dart';

class WelcomeState extends BaseBlocState<WelcomeState> {
  final int page;
  final bool isCompleted;

  WelcomeState({this.page = 0, this.isCompleted = false});

  @override
  WelcomeState copyWith({int? page, bool? isCompleted}) {
    return WelcomeState(
      page: page ?? this.page,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object> get props => [page, isCompleted];
}
