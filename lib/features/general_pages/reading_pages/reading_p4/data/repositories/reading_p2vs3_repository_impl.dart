import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/error/exceptions.dart';
import 'package:easyaptis/core/configs/error/failures.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/data/datasources/reading_p4_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/entities/reading_p4_entity.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/repositories/reading_p4_repository.dart';

class ReadingP4RepositoryImpl implements ReadingP4Repository {
  final ReadingP4RemoteDataSource remoteDataSource;
  ReadingP4RepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<ReadingP4Entity>>> getQuestionReadingP4({
    int? page,
    int? limit,
  }) async {
    try {
      final result = await remoteDataSource.getR4Questions(
        page: page,
        limit: limit,
      );
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
