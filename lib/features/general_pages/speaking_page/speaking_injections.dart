import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/data/datasources/speaking_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/data/repositories/speaking_p1_repository_impl.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/repositories/speaking_p1_repository.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/usecases/get_s1_questions.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/presentation/bloc/speaking_p1_bloc.dart';
import 'package:easyaptis/injection_container.dart';

initSpeakingInjections() {
  //! Features - Listening Part 1
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
}
