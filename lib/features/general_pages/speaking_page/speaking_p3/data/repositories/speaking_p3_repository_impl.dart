import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/data/datasources/speaking_p3_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/domain/entities/speaking_p3_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/domain/repositories/speaking_p3_repository.dart';

class SpeakingP3RepositoryImpl implements SpeakingP3Repository {
  final SpeakingP3RemoteDataSource remoteDataSource;
  SpeakingP3RepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<SpeakingP3Entity>>> getQuestionSpeakingP3({
    int? page,
    int? limit,
  }) async {
    try {
      final result = await remoteDataSource.getS3Questions(
        page: page,
        limit: limit,
      );
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
