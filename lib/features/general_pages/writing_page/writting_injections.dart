import 'package:easyaptis/features/general_pages/writing_page/club_details/data/datasources/wclubs_detail_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/data/repositories/wclubs_detail_repository_impl.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/domain/repositories/wclubs_detail_repository.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/domain/usecases/get_wclubs_detail.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/presentation/bloc/wclubs_detail_bloc.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/data/datasources/wclubs_local_datasource.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/data/datasources/wclubs_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/data/repositories/wclubs_repository_impl.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/repositories/wclubs_repository.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/usecases/get_wclubs_list.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/presentation/bloc/wclubs_bloc.dart';
import 'package:easyaptis/injection_container.dart';
import 'package:hive/hive.dart';

initWritingInjections() async {
  final writingBox = await Hive.openBox('writing_box');
  sl.registerLazySingleton<Box>(() => writingBox, instanceName: 'writing_box');

  //! Features - Writing Clubs
  // Bloc
  sl.registerFactory(() => WClubsBloc(getClubsList: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetWClubsList(sl()));
  // Repository
  sl.registerLazySingleton<WClubsRepository>(
    () => WClubsRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<WClubsRemoteDataSource>(
    () => WClubsRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<WClubsLocalDataSource>(
    () => WClubsLocalDataSourceImpl(sl(instanceName: 'writing_box')),
  );

  //! Features - Writing Club Details
  // Bloc
  sl.registerFactory(() => WClubsDetailBloc(getWClubsDetail: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetWClubsDetail(sl()));
  // Repository
  sl.registerLazySingleton<WClubsDetailRepository>(
    () => WClubsDetailRepositoryImpl(remoteDataSource: sl()),
  );
  // DataSource
  sl.registerLazySingleton<WClubsDetailRemoteDataSource>(
    () => WClubsDetailRemoteDataSourceImpl(firestore: sl()),
  );
}
