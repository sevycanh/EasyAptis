import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/data/datasources/speaking_p3_local_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/data/datasources/speaking_p3_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/domain/entities/speaking_p3_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/domain/repositories/speaking_p3_repository.dart';

class SpeakingP3RepositoryImpl implements SpeakingP3Repository {
  final SpeakingP3RemoteDataSource remoteDataSource;
  final SpeakingP3LocalDataSource localDataSource;
  final Duration cacheMaxAge = const Duration(
    days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
  );
  SpeakingP3RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<SpeakingP3Entity>>> getQuestionSpeakingP3({
    int? page,
    int? limit,
  }) async {
    try {
      final cached = localDataSource.getCachedQuestions(maxAge: cacheMaxAge);

      if (cached != null && cached.isNotEmpty) {
        return Right(cached.map((m) => m.toEntity()).toList());
      }

      final result = await remoteDataSource.getS3Questions(
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
