import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/data/datasources/listening_p2_local_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/data/datasources/listening_p2_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/domain/entities/listening_p2_entity.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/domain/repositories/listening_p2_repository.dart';

class ListeningP2RepositoryImpl implements ListeningP2Repository {
  final ListeningP2RemoteDataSource remoteDataSource;
  final ListeningP2LocalDataSource localDataSource;
  final Duration cacheMaxAge = const Duration(
    days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
  );
  ListeningP2RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<ListeningP2Entity>>> getQuestionListeningP2({
    int? page,
    int? limit,
  }) async {
    try {
      final cached = localDataSource.getCachedQuestions(maxAge: cacheMaxAge);

      if (cached != null && cached.isNotEmpty) {
        return Right(cached.map((m) => m.toEntity()).toList());
      }

      final result = await remoteDataSource.getL2Questions(
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
