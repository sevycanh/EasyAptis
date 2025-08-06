import 'package:EasyAptis/core/router/router.dart';
import 'package:EasyAptis/core/styles/app_colors.dart';
import 'package:EasyAptis/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyAptis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
          actionsIconTheme: IconThemeData(color: Colors.black),
          surfaceTintColor: AppColors.white
        ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: SplashPage(),
    );
  }
}