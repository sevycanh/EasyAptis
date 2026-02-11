part of 'network_observer_bloc.dart';

class NetworkObserverState extends Equatable {
  final bool isConnected;
  final bool justRecovered; 

  const NetworkObserverState({
    required this.isConnected,
    this.justRecovered = false,
  });

  const NetworkObserverState.initial()
      : isConnected = true,
        justRecovered = false;

  NetworkObserverState copyWith({
    bool? isConnected,
    bool? justRecovered,
  }) {
    return NetworkObserverState(
      isConnected: isConnected ?? this.isConnected,
      justRecovered: justRecovered ?? this.justRecovered,
    );
  }

  @override
  List<Object?> get props => [isConnected, justRecovered];
}
