import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easyaptis/core/configs/network/network_info.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_injections.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_injections.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_injections.dart';
import 'package:easyaptis/features/general_pages/writing_page/writting_injections.dart';
import 'package:easyaptis/features/home/presentation/bloc/home_bloc.dart';
import 'package:easyaptis/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:easyaptis/features/splash/data/sources/local/splash_shared_prefs.dart';
import 'package:easyaptis/features/splash/domain/repositories/splash_repository.dart';
import 'package:easyaptis/features/splash/domain/usecase/check_first_lauch.dart';
import 'package:easyaptis/features/welcome/data/repositories/welcome_repository_impl.dart';
import 'package:easyaptis/features/welcome/data/sources/local/welcome_shared_prefs.dart';
import 'package:easyaptis/features/welcome/domain/repositories/welcome_repository.dart';
import 'package:easyaptis/features/welcome/domain/usecases/set_not_first_lauch.dart';
import 'package:easyaptis/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:easyaptis/features/welcome/presentation/bloc/welcome_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Connectivity());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Modules
  await initReadingInjections();
  await initListeningInjections();
  await initWritingInjections();
  await initSpeakingInjections();

  //! Features - Splash
  // Bloc
  sl.registerFactory(
    () => SplashBloc(networkInfo: sl(), checkFirstLaunchUseCase: sl()),
  );
  // UseCase
  sl.registerLazySingleton(() => CheckFirstLaunch(sl()));
  // Repository
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl(sl()));
  // DataSource
  sl.registerLazySingleton<SplashSharedPrefs>(
    () => SplashSharedPrefsImpl(sharedPreferences: sl()),
  );

  //! Features - Welcome
  // Bloc
  sl.registerFactory(() => WelcomeBloc(setNotFirstLaunchUseCase: sl()));
  // UseCase
  sl.registerLazySingleton(() => SetNotFirstLaunch(sl()));
  // Repository
  sl.registerLazySingleton<WelcomeRepository>(
    () => WelcomeRepositoryImpl(sl()),
  );
  // DataSource
  sl.registerLazySingleton<WelcomeSharedPrefs>(
    () => WelcomeSharedPrefsImpl(sharedPreferences: sl()),
  );
  // Core
  // External

  //! Features - Home
  // Bloc
  sl.registerFactory(() => HomeBloc());
}
