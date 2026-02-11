import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/data/datasources/speaking_p2_local_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/data/datasources/speaking_p2_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/domain/entities/speaking_p2_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/domain/repositories/speaking_p2_repository.dart';

class SpeakingP2RepositoryImpl implements SpeakingP2Repository {
  final SpeakingP2RemoteDataSource remoteDataSource;
  final SpeakingP2LocalDataSource localDataSource;
  final Duration cacheMaxAge = const Duration(
    days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
  );
  SpeakingP2RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<SpeakingP2Entity>>> getQuestionSpeakingP2({
    int? page,
    int? limit,
  }) async {
    try {
      final cached = localDataSource.getCachedQuestions(maxAge: cacheMaxAge);

      if (cached != null && cached.isNotEmpty) {
        return Right(cached.map((m) => m.toEntity()).toList());
      }

      final result = await remoteDataSource.getS2Questions(
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
