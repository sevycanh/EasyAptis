import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/entities/wclubs_entity.dart';

abstract class WClubsRepository {

  Future<Either<Failure, List<WClubsEntity>>> getListOfClubs({
    int? page,
    int? limit,
  });
}
