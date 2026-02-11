import 'package:easyaptis/features/home/presentation/pages/home_page.dart';
import 'package:easyaptis/shared/notification/presentation/bloc/notification_event.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easyaptis/main.dart';
import 'package:easyaptis/shared/notification/presentation/bloc/notification_bloc.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // lưu navigation pending khi context chưa sẵn sàng
  String? _pendingNavigation;

  Future<void> init() async {
    await _messaging.requestPermission();

    // Init local notification
    const androidSettings = AndroidInitializationSettings('@drawable/ic_noti');
    const initSettings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) async {
        final payload = response.payload;
        if (payload != null) {
          await _handleNavigation(payload);
        }
      },
    );

    // Foreground
    FirebaseMessaging.onMessage.listen((msg) {
      _showLocalNotification(msg);
      _dispatchNotificationToBloc(msg);
    });

    // Background but app mở lại do user click
    FirebaseMessaging.onMessageOpenedApp.listen((msg) async {
      await _handleNavigation(msg.data['type']);
    });

    // TERMINATED
    final initialMsg = await _messaging.getInitialMessage();
    if (initialMsg != null) {
      final type = initialMsg.data['type'];
      if (type != null) {
        _pendingNavigation = type;
      }
    }

    // Chờ frame đầu tiên => khi navigatorKey.currentContext sẵn
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pendingNavigation != null) {
        final tmp = _pendingNavigation;
        _pendingNavigation = null;
        _handleNavigation(tmp);
      }
    });
  }

  // =====================================
  // LOCAL NOTIFICATION
  // =====================================
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@drawable/ic_noti',
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title ?? "Thông báo",
      notification.body ?? "",
      const NotificationDetails(android: androidDetails),
      payload: message.data['type'],
    );
  }

  // =====================================
  // ĐẨY ĐẾN BLoC
  // =====================================
  void _dispatchNotificationToBloc(RemoteMessage message) {
    final noti = message.notification;
    if (noti == null) return;

    final context = navigatorKey.currentContext;
    if (context == null) return;

    try {
      context.read<NotificationBloc>().add(
            NewNotificationReceived(
              body: noti.body ?? "",
            ),
          );
    } catch (_) {
      // nếu không có bloc, ignore
    }
  }

  // =====================================
  // NAVIGATION
  // =====================================
  Future<void> _handleNavigation(String? type) async {
    if (type == null) return;

    var context = navigatorKey.currentContext;
    if (context == null) {
      // app chưa build xong → retry 1 lần
      await Future.delayed(const Duration(milliseconds: 200));
      context = navigatorKey.currentContext;
      if (context == null) {
        // nếu vẫn không có context → lưu pending để xử lý sau
        _pendingNavigation = type;
        return;
      }
    }

    _navigate(type);
  }

  void _navigate(String type) {
    switch (type) {
      case 'answer':
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomePage()),
          (route) => false,
        );
        break;

      case 'chat':
        navigatorKey.currentState?.pushNamed('/chat');
        break;

      default:
        // default → quay về HomePage
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomePage()),
          (route) => false,
        );
        break;
    }
  }
}


// import 'package:easyaptis/features/home/presentation/pages/home_page.dart';
// import 'package:easyaptis/shared/notification/presentation/bloc/notification_event.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:easyaptis/main.dart';
// import 'package:easyaptis/shared/notification/presentation/bloc/notification_bloc.dart';

// class NotificationService {
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotifications =
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     await _messaging.requestPermission();

//     const androidSettings = AndroidInitializationSettings(
//       '@mipmap/ic_launcher',
//     );
//     const initSettings = InitializationSettings(android: androidSettings);

//     await _localNotifications.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (response) async {
//         if (response.payload != null) {
//           await _handleNavigation(response.payload);
//         }
//       },
//     );

//     FirebaseMessaging.onMessage.listen((msg) {
//       _showLocalNotification(msg);
//       _handleIncomingMessage(msg);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((msg) async {
//       await _handleNavigation(msg.data['type']);
//     });

//     final initialMsg = await _messaging.getInitialMessage();
//     if (initialMsg != null) {
//       await _handleNavigation(initialMsg.data['type']);
//     }
//   }

//   Future<void> _showLocalNotification(RemoteMessage message) async {
//     final notification = message.notification;
//     if (notification == null) return;

//     const androidDetails = AndroidNotificationDetails(
//       'default_channel',
//       'General Notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     await _localNotifications.show(
//       notification.hashCode,
//       notification.title ?? "Thông báo",
//       notification.body ?? "",
//       const NotificationDetails(android: androidDetails),
//       payload: message.data['type'],
//     );
//   }

//   void _handleIncomingMessage(RemoteMessage message) {
//     final notification = message.notification;
//     if (notification == null) return;

//     final context = navigatorKey.currentContext;
//     if (context != null) {
//       // nếu NotificationBloc chưa được cung cấp ở cấp cao hơn, call này sẽ throw —
//       // nhưng bạn dăng ký NotificationBloc ở runApp nên sẽ ok.
//       try {
//         context.read<NotificationBloc>().add(
//           NewNotificationReceived(body: notification.body ?? ""),
//         );
//       } catch (e) {
//         // nếu không có NotificationBloc, ignore (không crash)
//         debugPrint('No NotificationBloc available: $e');
//       }
//     }
//   }

//   Future<void> _handleNavigation(String? type) async {
//     if (type == null) return;

//     var context = navigatorKey.currentContext;
//     if (context == null) {
//       // retry once after short delay (no persistent pending storage)
//       await Future.delayed(const Duration(milliseconds: 300));
//       context = navigatorKey.currentContext;
//       if (context == null) {
//         debugPrint(
//           'Navigator context still null — skipping navigation for type=$type',
//         );
//         return;
//       }
//     }

//     _switchTab(type);
//   }

//   // Future<void> _navigateByType(BuildContext context, String type) async {
//   //   debugPrint("Navigate by type: $type");

//   //   // final homeBloc = _tryGetHomeBloc(context);

//   //   if (homeBloc == null) {
//   //     // chưa vào Home: push HomePage (reset stack), truyền initialType nếu bạn muốn
//   //     debugPrint('HomeBloc not found → push HomePage then set tab');
//   //     navigatorKey.currentState?.pushAndRemoveUntil(
//   //       MaterialPageRoute(builder: (_) => HomePage()),
//   //       (route) => false,
//   //     );

//   //     // sau khi push, đợi frame để HomePage mount; dùng addPostFrameCallback để an toàn
//   //     // WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     //   final newCtx = navigatorKey.currentContext;
//   //     //   final blocAfter = _tryGetHomeBloc(newCtx);
//   //     //   if (blocAfter != null) {
//   //     //     _switchTab(blocAfter, type);
//   //     //   } else {
//   //     //     debugPrint('HomeBloc still not available after pushing HomePage.');
//   //     //   }
//   //     // });
//   //     return;
//   //   }

//   //   // Nếu đã ở Home => chỉ chuyển tab hoặc push route
//   //   _switchTab(type);
//   // }

//   // HomeBloc? _tryGetHomeBloc(BuildContext? context) {
//   //   if (context == null) return null;
//   //   try {
//   //     return BlocProvider.of<HomeBloc>(context, listen: false);
//   //   } catch (_) {
//   //     return null;
//   //   }
//   // }

//   void _switchTab(String type) {
//     switch (type) {
//       case 'answer':
//         // bloc.add(ChangeTabEvent(1));
//         navigatorKey.currentState?.pushAndRemoveUntil(
//           MaterialPageRoute(builder: (_) => HomePage()),
//           (route) => false,
//         );
//         break;
//       case 'chat':
//         navigatorKey.currentState?.pushNamed('/chat');
//         break;
//       default:
//         // bloc.add(ChangeTabEvent(0));
//         break;
//     }
//   }
// }
