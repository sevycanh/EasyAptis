import 'package:easyaptis/injection_container.dart';
import 'package:easyaptis/shared/notification/presentation/bloc/notification_bloc.dart';

initNotificationInjections() {
  sl.registerFactory(() => NotificationBloc(sl()));
}
