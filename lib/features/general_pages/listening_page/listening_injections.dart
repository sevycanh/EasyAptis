import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/datasources/listening_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/repositories/listening_p1_repository_impl.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/repositories/listening_p1_repository.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/usecases/get_l1_questions.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/presentation/bloc/listening_p1_bloc.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/data/datasources/listening_p2_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/data/repositories/listening_p2_repository_impl.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/domain/repositories/listening_p2_repository.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/domain/usecases/get_l2_questions.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/presentation/bloc/listening_p2_bloc.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/data/datasources/listening_p3_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/data/repositories/listening_p3_repository_impl.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/repositories/listening_p3_repository.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/usecases/get_l3_questions.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/presentation/bloc/listening_p3_bloc.dart';
import 'package:easyaptis/injection_container.dart';

initListeningInjections() {
  //! Features - Listening Part 1
  // Bloc
  sl.registerFactory(() => ListeningP1Bloc(getQuestionListeningP1: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetL1Questions(sl()));
  // Repository
  sl.registerLazySingleton<ListeningP1Repository>(
    () => ListeningP1RepositoryImpl(remoteDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<ListeningP1RemoteDataSource>(
    () => ListeningP1RemoteDataSourceImpl(firestore: sl()),
  );

  //! Features - Listening Part 2
  // Bloc
  sl.registerFactory(() => ListeningP2Bloc(getQuestionListeningP2: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetL2Questions(sl()));
  // Repository
  sl.registerLazySingleton<ListeningP2Repository>(
    () => ListeningP2RepositoryImpl(remoteDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<ListeningP2RemoteDataSource>(
    () => ListeningP2RemoteDataSourceImpl(firestore: sl()),
  );

  //! Features - Listening Part 3
  // Bloc
  sl.registerFactory(() => ListeningP3Bloc(getQuestionListeningP3: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetL3Questions(sl()));
  // Repository
  sl.registerLazySingleton<ListeningP3Repository>(
    () => ListeningP3RepositoryImpl(remoteDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<ListeningP3RemoteDataSource>(
    () => ListeningP3RemoteDataSourceImpl(firestore: sl()),
  );
}
