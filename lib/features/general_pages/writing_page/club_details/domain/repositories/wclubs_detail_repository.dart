import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/domain/entities/topic_entity.dart';

abstract class WClubsDetailRepository {

  Future<Either<Failure, TopicEntity>> getDetailOfClub({
    required int clubId
  });
}
