import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/data/datasources/reading_p1_local_data_source.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/data/datasources/reading_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/entities/reading_p1.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/repositories/reading_p1_repos.dart';

class ReadingP1RepositoryImpl implements ReadingP1Repos {
  final ReadingP1RemoteDataSource remoteDataSource;
  final ReadingP1LocalDataSource localDataSource;
  final Duration cacheMaxAge;

  ReadingP1RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    this.cacheMaxAge = const Duration(
      days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
    ),
  });

  @override
  Future<Either<Failure, List<ReadingP1Entity>>> getQuestionReadingP1({
    int? page,
    int? limit,
    bool forceRefresh = false,
  }) async {
    try {
      final cached = localDataSource.getCachedQuestions(maxAge: cacheMaxAge);

      if (cached != null && cached.isNotEmpty && !forceRefresh) {
        return Right(cached.map((m) => m.toEntity()).toList());
      }

      final result = await remoteDataSource.getR1Questions(
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
