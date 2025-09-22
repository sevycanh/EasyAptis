import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/entities/listening_p1_entity.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/repositories/listening_p1_repository.dart';
import 'package:equatable/equatable.dart';

class GetL1Questions implements UseCase<List<ListeningP1Entity>, Params> {
  final ListeningP1Repository repository;

  GetL1Questions(this.repository);

  @override
  Future<Either<Failure, List<ListeningP1Entity>>> call(Params params) async {
    return await repository.getQuestionListeningP1(
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
