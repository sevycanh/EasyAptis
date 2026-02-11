import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easyaptis/core/router/router.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/core/services/notification_service.dart';
import 'package:easyaptis/features/splash/presentation/pages/splash_page.dart';
import 'package:easyaptis/shared/notification/presentation/bloc/notification_bloc.dart';
import 'package:easyaptis/shared/notification/presentation/bloc/notification_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/network/bloc/network_observer_bloc.dart';
import 'injection_container.dart' as di;
import 'firebase_options_dev.dart' as dev_options;
import 'firebase_options_prod.dart' as prod_options;

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
  } catch (_) {}
}

class FirebaseInitializer {
  static bool _initialized = false;
  static bool get isInitialized => _initialized;

  static Future<void> initSafely() async {
    if (_initialized) return;

    try {
      final flavor = dotenv.env['FLAVOR'];
      final options = flavor == 'prod'
          ? prod_options.DefaultFirebaseOptions.currentPlatform
          : dev_options.DefaultFirebaseOptions.currentPlatform;

      Firebase.initializeApp(options: options)
          .then((_) async {
            FirebaseMessaging.onBackgroundMessage(
              _firebaseMessagingBackgroundHandler,
            );
            await FirebaseMessaging.instance.subscribeToTopic("all");
            await di.sl<NotificationService>().init();

            _initialized = true;
            print("🔥 Firebase initialized successfully");
          })
          .catchError((e) {
            print("⚠️ Firebase init failed (will retry later): $e");
          });
    } catch (e) {
      print("⚠️ Firebase unexpected error: $e");
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseInitializer.initSafely();

    return MaterialApp(
      title: 'easyaptis',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: AppColors.white,
          actionsIconTheme: IconThemeData(color: Colors.black),
          surfaceTintColor: AppColors.white,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primaryColor,
          selectionColor: Color.fromARGB(50, 0, 122, 255),
          selectionHandleColor: AppColors.blue,
        ),
      ),
      builder: (context, child) {
        return BlocListener<NetworkObserverBloc, NetworkObserverState>(
          listener: (context, state) {
            if (!state.isConnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Không có kết nối mạng'),
                  backgroundColor: AppColors.red,
                  duration: Duration(days: 1),
                  dismissDirection: DismissDirection.none,
                ),
              );
            } else if (state.justRecovered) {
              // FirebaseInitializer.initSafely();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã khôi phục kết nối mạng'),
                  backgroundColor: AppColors.green,
                  duration: Duration(seconds: 2),
                  dismissDirection: DismissDirection.none,
                ),
              );
            }
          },
          child: child!,
        );
      },
      home: SplashPage(),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const envFile = String.fromEnvironment('ENV_FILE', defaultValue: '.env.dev');
  await dotenv.load(fileName: envFile);

  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NetworkObserverBloc(connectivity: Connectivity()),
        ),
        BlocProvider(
          create: (_) =>
              NotificationBloc(di.sl())..add(LoadSavedNotification()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
