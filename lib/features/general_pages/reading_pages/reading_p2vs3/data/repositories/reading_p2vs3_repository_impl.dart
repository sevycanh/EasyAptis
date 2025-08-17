import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/error/exceptions.dart';
import 'package:easyaptis/core/configs/error/failures.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/data/datasources/reading_p2vs3_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/entities/reading_p2vs3_entity.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/repositories/reading_p2vs3_repository.dart';

class ReadingP2vs3RepositoryImpl implements ReadingP2vs3Repository {
  final ReadingP2vs3RemoteDataSource remoteDataSource;
  ReadingP2vs3RepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<ReadingP2vs3Entity>>> getQuestionReadingP2vs3({
    int? page,
    int? limit,
  }) async {
    try {
      final result = await remoteDataSource.getR2vs3Questions(
        page: page,
        limit: limit,
      );
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
