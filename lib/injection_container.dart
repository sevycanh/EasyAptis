import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easyaptis/core/network/network_info.dart';
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
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // External
  sl.registerLazySingleton(() => Connectivity());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

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
