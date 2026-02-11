import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/data/datasources/listening_p4_local_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/data/datasources/listening_p4_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/domain/entities/listening_p4_entity.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/domain/repositories/listening_p4_repository.dart';

class ListeningP4RepositoryImpl implements ListeningP4Repository {
  final ListeningP4RemoteDataSource remoteDataSource;
  final ListeningP4LocalDataSource localDataSource;
  final Duration cacheMaxAge = const Duration(
    days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
  );
  ListeningP4RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<ListeningP4Entity>>> getQuestionListeningP4({
    int? page,
    int? limit,
  }) async {
    try {
      final cached = localDataSource.getCachedQuestions(maxAge: cacheMaxAge);

      if (cached != null && cached.isNotEmpty) {
        return Right(cached.map((m) => m.toEntity()).toList());
      }
      
      final result = await remoteDataSource.getL4Questions(
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
