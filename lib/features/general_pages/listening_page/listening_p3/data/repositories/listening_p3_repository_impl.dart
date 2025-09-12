import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/data/datasources/listening_p3_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/entities/listening_p3_entity.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/repositories/listening_p3_repository.dart';

class ListeningP3RepositoryImpl implements ListeningP3Repository {
  final ListeningP3RemoteDataSource remoteDataSource;
  ListeningP3RepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<ListeningP3Entity>>> getQuestionListeningP3({
    int? page,
    int? limit,
  }) async {
    try {
      final result = await remoteDataSource.getL3Questions(
        page: page,
        limit: limit,
      );
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
