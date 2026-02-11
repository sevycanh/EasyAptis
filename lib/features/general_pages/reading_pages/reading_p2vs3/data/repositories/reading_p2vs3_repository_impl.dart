import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/data/datasources/reading_p2vs3_local_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/data/datasources/reading_p2vs3_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/entities/reading_p2vs3_entity.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/repositories/reading_p2vs3_repository.dart';

class ReadingP2vs3RepositoryImpl implements ReadingP2vs3Repository {
  final ReadingP2vs3RemoteDataSource remoteDataSource;
  final ReadingP2vs3LocalDataSource localDataSource;
  final Duration cacheMaxAge;

  ReadingP2vs3RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    this.cacheMaxAge = const Duration(
      days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
    ),
  });
  
  @override
  Future<Either<Failure, List<ReadingP2vs3Entity>>> getQuestionReadingP2vs3({
    int? page,
    int? limit,
    bool forceRefresh = false,
  }) async {
    try {
      final cached = localDataSource.getCachedQuestions(maxAge: cacheMaxAge);

      if (cached != null && cached.isNotEmpty && !forceRefresh) {
        return Right(cached.map((m) => m.toEntity()).toList());
      }

      final result = await remoteDataSource.getR2vs3Questions(
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
