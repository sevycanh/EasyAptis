import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  SharedPreferences prefs;
  NotificationBloc(this.prefs) : super(const NotificationState()) {
    on<NewNotificationReceived>(_onNewNotification);
    on<LoadSavedNotification>(_onLoadSavedNotification);
    on<ClearNotification>(_onClearNotification);
  }

  Future<void> _onNewNotification(
      NewNotificationReceived event, Emitter<NotificationState> emit) async {
    final newState = state.copyWith(
      latestBody: event.body,
    );
    emit(newState);

    // final prefs = await SharedPreferences.getInstance();
    await prefs.setString('latestBody', event.body);
  }

  Future<void> _onLoadSavedNotification(
      LoadSavedNotification event, Emitter<NotificationState> emit) async {
    // final prefs = await SharedPreferences.getInstance();
    final body = prefs.getString('latestBody');

    emit(state.copyWith(latestBody: body));
  }

  Future<void> _onClearNotification(
      ClearNotification event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(clearBody: true)); 
    await prefs.remove('latestBody');
  }
}