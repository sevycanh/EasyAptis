import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/data/datasources/speaking_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/entities/speaking_p1_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/repositories/speaking_p1_repository.dart';

class SpeakingP1RepositoryImpl implements SpeakingP1Repository {
  final SpeakingP1RemoteDataSource remoteDataSource;
  SpeakingP1RepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<SpeakingP1Entity>>> getQuestionSpeakingP1({
    int? page,
    int? limit,
  }) async {
    try {
      final result = await remoteDataSource.getL1Questions(
        page: page,
        limit: limit,
      );
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
