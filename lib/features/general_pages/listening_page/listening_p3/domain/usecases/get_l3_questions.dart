import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/entities/listening_p3_entity.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/repositories/listening_p3_repository.dart';
import 'package:equatable/equatable.dart';

class GetL3Questions implements UseCase<List<ListeningP3Entity>, Params> {
  final ListeningP3Repository repository;

  GetL3Questions(this.repository);

  @override
  Future<Either<Failure, List<ListeningP3Entity>>> call(Params params) async {
    return await repository.getQuestionListeningP3(
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
