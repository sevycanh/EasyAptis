import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/data/datasources/reading_p1_local_data_source.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/data/datasources/reading_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/data/repositories/reading_p1_repos_impl.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/repositories/reading_p1_repos.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/usecases/get_r1_questions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/data/datasources/reading_p2vs3_local_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/data/datasources/reading_p2vs3_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/data/repositories/reading_p2vs3_repository_impl.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/repositories/reading_p2vs3_repository.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/usecases/get_r23_questions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/data/datasources/reading_p4_local_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/data/datasources/reading_p4_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/data/repositories/reading_p2vs3_repository_impl.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/repositories/reading_p4_repository.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/usecases/get_r4_questions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/presentation/bloc/reading_p4_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/data/datasources/reading_p5_local_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/data/datasources/reading_p5_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/data/repositories/reading_p5_repository_impl.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/repositories/reading_p5_repository.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/usecases/get_r5_questions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/presentation/bloc/reading_p5_bloc.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'reading_p1/presentation/bloc/reading_p1_bloc.dart';

initReadingInjections() async {
  final readingP1Box = await Hive.openBox('reading_p1_box');
  final readingP2P3Box = await Hive.openBox('reading_p2p3_box');
  final readingP4Box = await Hive.openBox('reading_p4_box');
  final readingP5Box = await Hive.openBox('reading_p5_box');
  sl.registerLazySingleton<Box>(
    () => readingP1Box,
    instanceName: 'reading_p1_box',
  );
  sl.registerLazySingleton<Box>(
    () => readingP2P3Box,
    instanceName: 'reading_p2p3_box',
  );
  sl.registerLazySingleton<Box>(
    () => readingP4Box,
    instanceName: 'reading_p4_box',
  );
  sl.registerLazySingleton<Box>(
    () => readingP5Box,
    instanceName: 'reading_p5_box',
  );

  //! Features - Reading Part 1
  // Bloc
  sl.registerFactory(() => ReadingP1Bloc(getQuestionReadingP1UseCase: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetR1Questions(sl()));
  // Repository
  sl.registerLazySingleton<ReadingP1Repos>(
    () =>
        ReadingP1RepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<ReadingP1RemoteDataSource>(
    () => ReadingP1RemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<ReadingP1LocalDataSource>(
    () => ReadingP1LocalDataSourceImpl(sl(instanceName: 'reading_p1_box')),
  );

  //! Features - Reading Part 2 vs 3
  // Bloc
  sl.registerFactory(
    () => ReadingP2vs3Bloc(getQuestionReadingP23UseCase: sl()),
  );
  // UseCase
  sl.registerLazySingleton(() => GetR23Questions(sl()));
  // Repository
  sl.registerLazySingleton<ReadingP2vs3Repository>(
    () => ReadingP2vs3RepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  // DataSource
  sl.registerLazySingleton<ReadingP2vs3RemoteDataSource>(
    () => ReadingP2vs3RemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ReadingP2vs3LocalDataSource>(
    () => ReadingP2vs3LocalDataSourceImpl(sl(instanceName: 'reading_p2p3_box')),
  );

  //! Features - Reading Part 4
  // Bloc
  sl.registerFactory(() => ReadingP4Bloc(getQuestionReadingP4: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetR4Questions(sl()));
  // Repository
  sl.registerLazySingleton<ReadingP4Repository>(
    () =>
        ReadingP4RepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<ReadingP4RemoteDataSource>(
    () => ReadingP4RemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ReadingP4LocalDataSource>(
    () => ReadingP4LocalDataSourceImpl(sl(instanceName: 'reading_p4_box')),
  );

  //! Features - Reading Part 5
  // Bloc
  sl.registerFactory(() => ReadingP5Bloc(getQuestionReadingP5: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetR5Questions(sl()));
  // Repository
  sl.registerLazySingleton<ReadingP5Repository>(
    () =>
        ReadingP5RepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<ReadingP5RemoteDataSource>(
    () => ReadingP5RemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ReadingP5LocalDataSource>(
    () => ReadingP5LocalDataSourceImpl(sl(instanceName: 'reading_p5_box')),
  );
}
