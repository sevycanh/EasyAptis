import 'dart:async';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/domain/usecases/get_l2_questions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'listening_p2_event.dart';
import 'listening_p2_state.dart';

class ListeningP2Bloc extends BaseBloc<ListeningP2Event, ListeningP2State> {
  final GetL2Questions getQuestionListeningP2;
  final AudioPlayer _player = AudioPlayer();
  late final StreamSubscription<PlayerState> _playerSubscription;

  ListeningP2Bloc({required this.getQuestionListeningP2})
    : super(ListeningP2State()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<CheckAnswer>(_onCheckAnswer);
    on<AnswerSelected>(_onAnswerSelected);
    on<ToggleTranscript>(_onToggleTranscript);
    on<ToggleAudio>(_onToggleAudio);
    on<AudioCompleted>(_onAudioCompleted);

    _playerSubscription = _player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        add(AudioCompleted());
      }
    });
  }

  @override
  Future<void> close() {
    _playerSubscription.cancel();
    _player.dispose();
    return super.close();
  }

  Future<void> _onToggleAudio(
    ToggleAudio event,
    Emitter<ListeningP2State> emit,
  ) async {
    if (state.isPlaying) {
      await _player.stop();
      emit(state.copyWith(isPlaying: false));
    } else {
      await _player.stop();
      await _player.setUrl(event.url);
      emit(state.copyWith(isPlaying: true));
      await _player.play();
    }
  }

  void _onAudioCompleted(AudioCompleted event, Emitter<ListeningP2State> emit) {
    emit(state.copyWith(isPlaying: false));
  }

  Future<void> _onLoadQuestions(
    LoadQuestions event,
    Emitter<ListeningP2State> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));

    final result = await getQuestionListeningP2(
      Params(page: event.page, limit: event.limit),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (questions) {
        emit(
          state.copyWith(
            isLoading: false,
            listQuestion: questions,
            currentIndex: 0,
            selectedAnswers: {},
            transcriptVisible: {},
          ),
        );
      },
    );
  }

  void _onNextQuestion(
    NextQuestion event,
    Emitter<ListeningP2State> emit,
  ) async {
    if (state.currentIndex < state.listQuestion.length - 1) {
      await _player.stop();
      emit(
        state.copyWith(currentIndex: state.currentIndex + 1, isPlaying: false),
      );
    }
  }

  void _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<ListeningP2State> emit,
  ) async {
    if (state.currentIndex > 0) {
      await _player.stop();
      emit(
        state.copyWith(currentIndex: state.currentIndex - 1, isPlaying: false),
      );
    }
  }

  void _onCheckAnswer(CheckAnswer event, Emitter<ListeningP2State> emit) {
    final current = state.currentIndex;
    final entity = state.listQuestion[current];

    final selectedForQuestion = state.selectedAnswers[current] ?? {};

    final newCheckedAnswers = Map<int, Map<int, bool?>>.from(
      state.checkedAnswers,
    );

    final speakerMap = <int, bool?>{};
    for (var sp in entity.speakers) {
      final selected = selectedForQuestion[sp.speaker];
      if (selected == null) {
        speakerMap[sp.speaker] = null;
      } else if (selected == sp.correctOption) {
        speakerMap[sp.speaker] = true;
      } else {
        speakerMap[sp.speaker] = false;
      }
    }

    newCheckedAnswers[current] = speakerMap;

    final newCheckedQuestions = Set<int>.from(state.checkedQuestions)
      ..add(current);

    emit(
      state.copyWith(
        checkedAnswers: newCheckedAnswers,
        checkedQuestions: newCheckedQuestions,
      ),
    );
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<ListeningP2State> emit) {
    final newSelected = Map<int, Map<int, int?>>.from(state.selectedAnswers);
    final questionMap = Map<int, int?>.from(
      newSelected[event.questionIndex] ?? {},
    );
    questionMap[event.speakerIndex] = event.optionIndex;
    newSelected[event.questionIndex] = questionMap;
    emit(state.copyWith(selectedAnswers: newSelected));
  }

  void _onToggleTranscript(
    ToggleTranscript event,
    Emitter<ListeningP2State> emit,
  ) {
    final newSet = Set<int>.from(state.transcriptVisible);
    if (newSet.contains(event.questionIndex)) {
      newSet.remove(event.questionIndex);
    } else {
      newSet.add(event.questionIndex);
    }
    emit(state.copyWith(transcriptVisible: newSet));
  }
}
