import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/data/datasources/listening_p3_local_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/data/datasources/listening_p3_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/entities/listening_p3_entity.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/repositories/listening_p3_repository.dart';

class ListeningP3RepositoryImpl implements ListeningP3Repository {
  final ListeningP3RemoteDataSource remoteDataSource;
  final ListeningP3LocalDataSource localDataSource;
  final Duration cacheMaxAge = const Duration(
    days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
  );
  
  ListeningP3RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<ListeningP3Entity>>> getQuestionListeningP3({
    int? page,
    int? limit,
  }) async {
    try {
      final cached = localDataSource.getCachedQuestions(maxAge: cacheMaxAge);

      if (cached != null && cached.isNotEmpty) {
        return Right(cached.map((m) => m.toEntity()).toList());
      }

      final result = await remoteDataSource.getL3Questions(
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
