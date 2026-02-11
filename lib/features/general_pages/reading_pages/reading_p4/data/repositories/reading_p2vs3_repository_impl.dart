import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/data/datasources/reading_p4_local_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/data/datasources/reading_p4_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/entities/reading_p4_entity.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/repositories/reading_p4_repository.dart';

class ReadingP4RepositoryImpl implements ReadingP4Repository {
  final ReadingP4RemoteDataSource remoteDataSource;
  final ReadingP4LocalDataSource localDataSource;
  final Duration cacheMaxAge = const Duration(
    days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
  );

  ReadingP4RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<ReadingP4Entity>>> getQuestionReadingP4({
    int? page,
    int? limit,
    bool forceRefresh = false,
  }) async {
    try {
      final cached = localDataSource.getCachedQuestions(maxAge: cacheMaxAge);

      if (cached != null && cached.isNotEmpty && !forceRefresh) {
        return Right(cached.map((m) => m.toEntity()).toList());
      }

      final result = await remoteDataSource.getR4Questions(
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
