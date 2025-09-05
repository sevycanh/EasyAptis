import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/error/exceptions.dart';
import 'package:easyaptis/core/configs/error/failures.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/data/datasources/reading_p5_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/entities/reading_p5_entity.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/repositories/reading_p5_repository.dart';

class ReadingP5RepositoryImpl implements ReadingP5Repository {
  final ReadingP5RemoteDataSource remoteDataSource;
  ReadingP5RepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<ReadingP5Entity>>> getQuestionReadingP5({
    int? page,
    int? limit,
  }) async {
    try {
      final result = await remoteDataSource.getR5Questions(
        page: page,
        limit: limit,
      );
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
