abstract class NotificationEvent {}

class NewNotificationReceived extends NotificationEvent {
  // final String title;
  final String body;
  NewNotificationReceived({required this.body});
}

class LoadSavedNotification extends NotificationEvent {}

class ClearNotification extends NotificationEvent {} 