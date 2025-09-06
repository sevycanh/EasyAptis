import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/datasources/listening_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/entities/listening_p1_entity.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/repositories/listening_p1_repository.dart';

class ListeningP1RepositoryImpl implements ListeningP1Repository {
  final ListeningP1RemoteDataSource remoteDataSource;
  ListeningP1RepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<ListeningP1Entity>>> getQuestionListeningP1({
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
