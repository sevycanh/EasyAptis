import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_observer_event.dart';
part 'network_observer_state.dart';

class NetworkObserverBloc
    extends Bloc<NetworkObserverEvent, NetworkObserverState> {
  final Connectivity connectivity;
  late final StreamSubscription _subscription;

  bool _wasDisconnected = false;
  bool _isInitialCheckDone = false;

  NetworkObserverBloc({required this.connectivity})
      : super(const NetworkObserverState.initial()) {
    on<_NetworkStatusChanged>(_onStatusChanged);

    _subscription = connectivity.onConnectivityChanged.listen((results) {
      final hasConnection = results.any((r) => r != ConnectivityResult.none);
      add(_NetworkStatusChanged(hasConnection));
    });

    _initCheck(); 
  }

  Future<void> _initCheck() async {
    final results = await connectivity.checkConnectivity();
    final hasConnection = results.any((r) => r != ConnectivityResult.none);
    _isInitialCheckDone = true;
    add(_NetworkStatusChanged(hasConnection)); 
  }

  void _onStatusChanged(
  _NetworkStatusChanged event,
  Emitter<NetworkObserverState> emit,
) {
  if (!_isInitialCheckDone) {
    emit(state.copyWith(isConnected: event.isConnected, justRecovered: false));
    return;
  }

  if (!event.isConnected) {
    _wasDisconnected = true;
    emit(state.copyWith(isConnected: false, justRecovered: false));
  } else {
    emit(state.copyWith(
      isConnected: true,
      justRecovered: _wasDisconnected,
    ));
    _wasDisconnected = false;
  }
}


  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
