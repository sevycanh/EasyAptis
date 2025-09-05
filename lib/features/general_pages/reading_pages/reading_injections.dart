import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/data/datasources/reading_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/data/repositories/reading_p1_repos_impl.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/repositories/reading_p1_repos.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/usecases/get_r1_questions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/data/datasources/reading_p2vs3_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/data/repositories/reading_p2vs3_repository_impl.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/repositories/reading_p2vs3_repository.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/usecases/get_r23_questions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/bloc/reading_p2vs3_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/data/datasources/reading_p4_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/data/repositories/reading_p2vs3_repository_impl.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/repositories/reading_p4_repository.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/usecases/get_r4_questions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/presentation/bloc/reading_p4_bloc.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/data/datasources/reading_p5_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/data/repositories/reading_p5_repository_impl.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/repositories/reading_p5_repository.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/usecases/get_r5_questions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/presentation/bloc/reading_p5_bloc.dart';
import 'package:easyaptis/injection_container.dart';

import 'reading_p1/presentation/bloc/reading_p1_bloc.dart';

initReadingInjections() {
  //! Features - Reading Part 1
  // Bloc
  sl.registerFactory(() => ReadingP1Bloc(getQuestionReadingP1UseCase: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetR1Questions(sl()));
  // Repository
  sl.registerLazySingleton<ReadingP1Repos>(() => ReadingP1RepositoryImpl(sl()));
  // DataSource
  sl.registerLazySingleton<ReadingP1RemoteDataSource>(
    () => ReadingP1RemoteDataSourceImpl(firestore: sl()),
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
    () => ReadingP2vs3RepositoryImpl(remoteDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<ReadingP2vs3RemoteDataSource>(
    () => ReadingP2vs3RemoteDataSourceImpl(firestore: sl()),
  );

  //! Features - Reading Part 4
  // Bloc
  sl.registerFactory(() => ReadingP4Bloc(getQuestionReadingP4: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetR4Questions(sl()));
  // Repository
  sl.registerLazySingleton<ReadingP4Repository>(
    () => ReadingP4RepositoryImpl(remoteDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<ReadingP4RemoteDataSource>(
    () => ReadingP4RemoteDataSourceImpl(firestore: sl()),
  );

  //! Features - Reading Part 5
  // Bloc
  sl.registerFactory(() => ReadingP5Bloc(getQuestionReadingP5: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetR5Questions(sl()));
  // Repository
  sl.registerLazySingleton<ReadingP5Repository>(
    () => ReadingP5RepositoryImpl(remoteDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<ReadingP5RemoteDataSource>(
    () => ReadingP5RemoteDataSourceImpl(firestore: sl()),
  );
}
