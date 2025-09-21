import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/entities/wclubs_entity.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/repositories/wclubs_repository.dart';
import 'package:equatable/equatable.dart';

class GetWClubsList implements UseCase<List<WClubsEntity>, Params> {
  final WClubsRepository repository;

  GetWClubsList(this.repository);

  @override
  Future<Either<Failure, List<WClubsEntity>>> call(Params params) async {
    return await repository.getListOfClubs(
      page: params.page,
      limit: params.limit,
    );
  }
}

class Params extends Equatable {
  final int? page;
  final int? limit;

  const Params({this.page, this.limit});

  @override
  List<Object?> get props => [page, limit];
}
