part of 'network_observer_bloc.dart';

abstract class NetworkObserverEvent extends Equatable {
  const NetworkObserverEvent();

  @override
  List<Object?> get props => [];
}

class _NetworkStatusChanged extends NetworkObserverEvent {
  final bool isConnected;
  const _NetworkStatusChanged(this.isConnected);

  @override
  List<Object?> get props => [isConnected];
}
