import 'package:easyaptis/core/router/router.dart';
import 'package:easyaptis/core/configs/styles/app_colors.dart';
import 'package:easyaptis/features/splash/presentation/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'injection_container.dart' as di;
import 'firebase_options_dev.dart' as dev_options;
import 'firebase_options_prod.dart' as prod_options;

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  const envFile = String.fromEnvironment('ENV_FILE', defaultValue: '.env.dev');
  await dotenv.load(fileName: envFile);

  final flavor = dotenv.env['FLAVOR'];

  FirebaseOptions options;
  if (flavor == 'prod') {
    options = prod_options.DefaultFirebaseOptions.currentPlatform;
  } else {
    options = dev_options.DefaultFirebaseOptions.currentPlatform;
  }

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: options);

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'easyaptis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
          actionsIconTheme: IconThemeData(color: Colors.black),
          surfaceTintColor: AppColors.white,
          centerTitle: true
        ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: SplashPage(),
    );
  }
}
