import 'dart:async';
import 'package:easyaptis/features/general_pages/writing_page/club_details/domain/usecases/get_wclubs_detail.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/presentation/bloc/wclubs_detail_event.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/presentation/bloc/wclubs_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easyaptis/core/utils/base/base_bloc.dart';

class WClubsDetailBloc
    extends BaseBloc<WClubsDetailEvent, WClubsDetailState> {
  final GetWClubsDetail getWClubsDetail;

  WClubsDetailBloc({required this.getWClubsDetail})
      : super(WClubsDetailState()) {
    on<LoadClubDetails>(_onLoadClubDetails);
    on<NextPart>(_onNextPart);
    on<PreviousPart>(_onPreviousPart);
    on<UpdateAnswer>(_onUpdateAnswer);
  }

  Future<void> _onLoadClubDetails(
    LoadClubDetails event,
    Emitter<WClubsDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));
    final result = await getWClubsDetail(Params(clubId: event.clubId));

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (topic) {
        emit(state.copyWith(isLoading: false, topic: topic, currentPart: 1));
      },
    );
  }

  void _onNextPart(NextPart event, Emitter<WClubsDetailState> emit) {
    final maxPart = state.topic?.parts.length ?? 1;
    if (state.currentPart < maxPart) {
      emit(state.copyWith(currentPart: state.currentPart + 1));
    }
  }

  void _onPreviousPart(PreviousPart event, Emitter<WClubsDetailState> emit) {
    if (state.currentPart > 1) {
      emit(state.copyWith(currentPart: state.currentPart - 1));
    }
  }

  void _onUpdateAnswer(UpdateAnswer event, Emitter<WClubsDetailState> emit) {
    final newAnswers = Map<int, Map<int, String>>.from(state.answers);

    if (!newAnswers.containsKey(event.partId)) {
      newAnswers[event.partId] = {};
    }

    newAnswers[event.partId] = Map<int, String>.from(newAnswers[event.partId]!);
    newAnswers[event.partId]![event.questionId] = event.answer;

    emit(state.copyWith(answers: newAnswers));
  }
}
