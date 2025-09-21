import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/entities/wclubs_entity.dart';

class WClubsState extends BaseBlocState {
  final bool isLoading;
  final String error;
  final List<WClubsEntity> clubs;

  WClubsState({
    this.isLoading = false,
    this.error = "",
    this.clubs = const [],
  });

  @override
  WClubsState copyWith({
    bool? isLoading,
    String? error,
    List<WClubsEntity>? clubs,
  }) {
    return WClubsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      clubs: clubs ?? this.clubs,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, clubs];
}
