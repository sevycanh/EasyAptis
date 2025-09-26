import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/data/datasources/speaking_p2_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/domain/entities/speaking_p2_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/domain/repositories/speaking_p2_repository.dart';

class SpeakingP2RepositoryImpl implements SpeakingP2Repository {
  final SpeakingP2RemoteDataSource remoteDataSource;
  SpeakingP2RepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<SpeakingP2Entity>>> getQuestionSpeakingP2({
    int? page,
    int? limit,
  }) async {
    try {
      final result = await remoteDataSource.getS2Questions(
        page: page,
        limit: limit,
      );
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
