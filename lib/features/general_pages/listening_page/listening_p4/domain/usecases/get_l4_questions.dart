import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/domain/entities/listening_p4_entity.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/domain/repositories/listening_p4_repository.dart';
import 'package:equatable/equatable.dart';

class GetL4Questions implements UseCase<List<ListeningP4Entity>, Params> {
  final ListeningP4Repository repository;

  GetL4Questions(this.repository);

  @override
  Future<Either<Failure, List<ListeningP4Entity>>> call(Params params) async {
    return await repository.getQuestionListeningP4(
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
