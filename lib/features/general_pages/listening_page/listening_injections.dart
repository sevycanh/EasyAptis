import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/datasources/listening_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/repositories/listening_p1_repository_impl.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/repositories/listening_p1_repository.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/usecases/get_l1_questions.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/presentation/bloc/listening_p1_bloc.dart';
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
}
