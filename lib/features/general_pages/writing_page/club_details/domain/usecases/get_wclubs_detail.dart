import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/domain/entities/topic_entity.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/domain/repositories/wclubs_detail_repository.dart';
import 'package:equatable/equatable.dart';

class GetWClubsDetail implements UseCase<TopicEntity, Params> {
  final WClubsDetailRepository repository;

  GetWClubsDetail(this.repository);

  @override
  Future<Either<Failure, TopicEntity>> call(Params params) async {
    return await repository.getDetailOfClub(clubId: params.clubId);
  }
}

class Params extends Equatable {
  final int clubId;

  const Params({required this.clubId});

  @override
  List<Object?> get props => [clubId];
}
