import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/data/datasources/reading_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/entities/reading_p1.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/repositories/reading_p1_repos.dart';

class ReadingP1RepositoryImpl implements ReadingP1Repos {
  final ReadingP1RemoteDataSource remoteDataSource;

  ReadingP1RepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ReadingP1Entity>>> getQuestionReadingP1({
    int? page,
    int? limit,
  }) async {
    try {
      final result = await remoteDataSource.getR1Questions(
        page: page,
        limit: limit,
      );
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
