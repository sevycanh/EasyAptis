import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/data/datasources/wclubs_local_datasource.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/data/datasources/wclubs_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/entities/wclubs_entity.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/repositories/wclubs_repository.dart';

class WClubsRepositoryImpl implements WClubsRepository {
  final WClubsRemoteDataSource remoteDataSource;
  final WClubsLocalDataSource localDataSource;
  final Duration cacheMaxAge;

  WClubsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    this.cacheMaxAge = const Duration(
      days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
    ),
  });

  @override
  Future<Either<Failure, List<WClubsEntity>>> getListOfClubs({
    int? page,
    int? limit,
    bool forceRefresh = false,
  }) async {
    try {
      final cached = localDataSource.getCachedQuestions(maxAge: cacheMaxAge);

      if (cached != null && cached.isNotEmpty && !forceRefresh) {
        return Right(cached.map((m) => m.toEntity()).toList());
      }
      
      final result = await remoteDataSource.getListOfClubs(
        page: page,
        limit: limit,
      );
      await localDataSource.cacheQuestions(result);
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
