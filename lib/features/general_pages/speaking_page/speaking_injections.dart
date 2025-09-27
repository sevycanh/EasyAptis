import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/data/datasources/speaking_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/data/repositories/speaking_p1_repository_impl.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/repositories/speaking_p1_repository.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/usecases/get_s1_questions.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/presentation/bloc/speaking_p1_bloc.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/data/datasources/speaking_p2_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/data/repositories/speaking_p2_repository_impl.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/domain/repositories/speaking_p2_repository.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/domain/usecases/get_s2_questions.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/presentation/bloc/speaking_p2_bloc.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/data/datasources/speaking_p3_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/data/repositories/speaking_p3_repository_impl.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/domain/repositories/speaking_p3_repository.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/domain/usecases/get_s3_questions.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/presentation/bloc/speaking_p3_bloc.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/data/datasources/speaking_p4_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/data/repositories/speaking_p4_repository_impl.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/domain/repositories/speaking_p4_repository.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/domain/usecases/get_s4_questions.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/presentation/bloc/speaking_p4_bloc.dart';
import 'package:easyaptis/injection_container.dart';

initSpeakingInjections() {
  //! Features - Speaking Part 1
  // Bloc
  sl.registerFactory(() => SpeakingP1Bloc(getQuestionSpeakingP1: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetS1Questions(sl()));
  // Repository
  sl.registerLazySingleton<SpeakingP1Repository>(
    () => SpeakingP1RepositoryImpl(remoteDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<SpeakingP1RemoteDataSource>(
    () => SpeakingP1RemoteDataSourceImpl(firestore: sl()),
  );

  //! Features - Speaking Part 2
  // Bloc
  sl.registerFactory(() => SpeakingP2Bloc(getQuestionSpeakingP2: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetS2Questions(sl()));
  // Repository
  sl.registerLazySingleton<SpeakingP2Repository>(
    () => SpeakingP2RepositoryImpl(remoteDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<SpeakingP2RemoteDataSource>(
    () => SpeakingP2RemoteDataSourceImpl(firestore: sl()),
  );

  //! Features - Speaking Part 3
  // Bloc
  sl.registerFactory(() => SpeakingP3Bloc(getQuestionSpeakingP3: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetS3Questions(sl()));
  // Repository
  sl.registerLazySingleton<SpeakingP3Repository>(
    () => SpeakingP3RepositoryImpl(remoteDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<SpeakingP3RemoteDataSource>(
    () => SpeakingP3RemoteDataSourceImpl(firestore: sl()),
  );

  //! Features - Speaking Part 4
  // Bloc
  sl.registerFactory(() => SpeakingP4Bloc(getQuestionSpeakingP4: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetS4Questions(sl()));
  // Repository
  sl.registerLazySingleton<SpeakingP4Repository>(
    () => SpeakingP4RepositoryImpl(remoteDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<SpeakingP4RemoteDataSource>(
    () => SpeakingP4RemoteDataSourceImpl(firestore: sl()),
  );
}
