import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/data/datasources/wclubs_detail_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/domain/entities/topic_entity.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/domain/repositories/wclubs_detail_repository.dart';

class WClubsDetailRepositoryImpl implements WClubsDetailRepository {
  final WClubsDetailRemoteDataSource remoteDataSource;
  WClubsDetailRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, TopicEntity>> getDetailOfClub({
    required int clubId,
  }) async {
    try {
      final result = await remoteDataSource.getDetailOfClub(clubId: clubId);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
