import 'package:easyaptis/core/base/base_bloc_state.dart';

class HomeState extends BaseBlocState<HomeState> {
  final int currentTab;

  HomeState({this.currentTab = 0});

  @override
  HomeState copyWith({int? currentTab}) {
    return HomeState(currentTab: currentTab ?? this.currentTab);
  }

  @override
  List<Object> get props => [currentTab];
}
