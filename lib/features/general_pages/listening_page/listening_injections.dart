import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/datasources/listening_p1_local_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/datasources/listening_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/repositories/listening_p1_repository_impl.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/repositories/listening_p1_repository.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/usecases/get_l1_questions.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/presentation/bloc/listening_p1_bloc.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/data/datasources/listening_p2_local_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/data/datasources/listening_p2_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/data/repositories/listening_p2_repository_impl.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/domain/repositories/listening_p2_repository.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/domain/usecases/get_l2_questions.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/presentation/bloc/listening_p2_bloc.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/data/datasources/listening_p3_local_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/data/datasources/listening_p3_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/data/repositories/listening_p3_repository_impl.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/repositories/listening_p3_repository.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/usecases/get_l3_questions.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/presentation/bloc/listening_p3_bloc.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/data/datasources/listening_p4_local_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/data/datasources/listening_p4_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/data/repositories/listening_p4_repository_impl.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/domain/repositories/listening_p4_repository.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/domain/usecases/get_l4_questions.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/presentation/bloc/listening_p4_bloc.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:hive_flutter/hive_flutter.dart';

initListeningInjections() async {
  final listeningP1Box = await Hive.openBox('listening_p1_box');
  final listeningP2Box = await Hive.openBox('listening_p2_box');
  final listeningP3Box = await Hive.openBox('listening_p3_box');
  final listeningP4Box = await Hive.openBox('listening_p4_box');
  sl.registerLazySingleton<Box>(
    () => listeningP1Box,
    instanceName: 'listening_p1_box',
  );
  sl.registerLazySingleton<Box>(
    () => listeningP2Box,
    instanceName: 'listening_p2_box',
  );
  sl.registerLazySingleton<Box>(
    () => listeningP3Box,
    instanceName: 'listening_p3_box',
  );
  sl.registerLazySingleton<Box>(
    () => listeningP4Box,
    instanceName: 'listening_p4_box',
  );
  //! Features - Listening Part 1
  // Bloc
  sl.registerFactory(() => ListeningP1Bloc(getQuestionListeningP1: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetL1Questions(sl()));
  // Repository
  sl.registerLazySingleton<ListeningP1Repository>(
    () => ListeningP1RepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  // DataSource
  sl.registerLazySingleton<ListeningP1RemoteDataSource>(
    () => ListeningP1RemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ListeningP1LocalDataSource>(
    () => ListeningP1LocalDataSourceImpl(sl(instanceName: 'listening_p1_box')),
  );

  //! Features - Listening Part 2
  // Bloc
  sl.registerFactory(() => ListeningP2Bloc(getQuestionListeningP2: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetL2Questions(sl()));
  // Repository
  sl.registerLazySingleton<ListeningP2Repository>(
    () => ListeningP2RepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  // DataSource
  sl.registerLazySingleton<ListeningP2RemoteDataSource>(
    () => ListeningP2RemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ListeningP2LocalDataSource>(
    () => ListeningP2LocalDataSourceImpl(sl(instanceName: 'listening_p2_box')),
  );

  //! Features - Listening Part 3
  // Bloc
  sl.registerFactory(() => ListeningP3Bloc(getQuestionListeningP3: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetL3Questions(sl()));
  // Repository
  sl.registerLazySingleton<ListeningP3Repository>(
    () => ListeningP3RepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  // DataSource
  sl.registerLazySingleton<ListeningP3RemoteDataSource>(
    () => ListeningP3RemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ListeningP3LocalDataSource>(
    () => ListeningP3LocalDataSourceImpl(sl(instanceName: 'listening_p3_box')),
  );

  //! Features - Listening Part 4
  // Bloc
  sl.registerFactory(() => ListeningP4Bloc(getQuestionListeningP4: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetL4Questions(sl()));
  // Repository
  sl.registerLazySingleton<ListeningP4Repository>(
    () => ListeningP4RepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  // DataSource
  sl.registerLazySingleton<ListeningP4RemoteDataSource>(
    () => ListeningP4RemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ListeningP4LocalDataSource>(
    () => ListeningP4LocalDataSourceImpl(sl(instanceName: 'listening_p4_box')),
  );
}
