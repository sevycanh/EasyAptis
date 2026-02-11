import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/data/datasources/speaking_p4_local_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/data/datasources/speaking_p4_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/domain/entities/speaking_p4_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/domain/repositories/speaking_p4_repository.dart';

class SpeakingP4RepositoryImpl implements SpeakingP4Repository {
  final SpeakingP4RemoteDataSource remoteDataSource;
  final SpeakingP4LocalDataSource localDataSource;
  final Duration cacheMaxAge = const Duration(
    days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
  );
  SpeakingP4RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<SpeakingP4Entity>>> getQuestionSpeakingP4({
    int? page,
    int? limit,
  }) async {
    try {
      final cached = localDataSource.getCachedQuestions(maxAge: cacheMaxAge);

      if (cached != null && cached.isNotEmpty) {
        return Right(cached.map((m) => m.toEntity()).toList());
      }

      final result = await remoteDataSource.getS4Questions(
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
