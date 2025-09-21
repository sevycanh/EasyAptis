import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/data/datasources/wclubs_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/entities/wclubs_entity.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/repositories/wclubs_repository.dart';

class WClubsRepositoryImpl implements WClubsRepository {
  final WClubsRemoteDataSource remoteDataSource;
  WClubsRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<WClubsEntity>>> getListOfClubs({
    int? page,
    int? limit,
  }) async {
    try {
      final result = await remoteDataSource.getListOfClubs(
        page: page,
        limit: limit,
      );
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
