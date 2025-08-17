import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/entities/reading_p2vs3_entity.dart';

class ReadingP2vs3State extends BaseBlocState {
  final bool isLoading;
  final List<ReadingP2vs3Entity> listQuestion;
  final String error;
  final int currentIndex;
  final List<OptionR2vs3Entity> currentOrder;
  final Map<int, List<OptionR2vs3Entity>> ordersMap;
  final Map<int, Map<String, bool>> answersStatusMap;

  ReadingP2vs3State({
    this.isLoading = false,
    this.listQuestion = const [],
    this.error = '',
    this.currentIndex = 0,
    this.currentOrder = const [],
    this.ordersMap = const {},
    this.answersStatusMap = const {},
  });

  @override
  ReadingP2vs3State copyWith({
    bool? isLoading,
    List<ReadingP2vs3Entity>? listQuestion,
    String? error,
    int? currentIndex,
    List<OptionR2vs3Entity>? currentOrder,
    Map<int, List<OptionR2vs3Entity>>? ordersMap,
    Map<int, Map<String, bool>>? answersStatusMap,
  }) {
    return ReadingP2vs3State(
      isLoading: isLoading ?? this.isLoading,
      listQuestion: listQuestion ?? this.listQuestion,
      error: error ?? this.error,
      currentIndex: currentIndex ?? this.currentIndex,
      currentOrder: currentOrder ?? this.currentOrder,
      ordersMap: ordersMap ?? this.ordersMap,
      answersStatusMap: answersStatusMap ?? this.answersStatusMap,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    listQuestion,
    error,
    currentIndex,
    currentOrder,
    ordersMap,
    answersStatusMap,
  ];
}
