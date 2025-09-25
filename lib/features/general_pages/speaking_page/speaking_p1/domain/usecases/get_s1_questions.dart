import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/entities/speaking_p1_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/repositories/speaking_p1_repository.dart';
import 'package:equatable/equatable.dart';

class GetS1Questions implements UseCase<List<SpeakingP1Entity>, Params> {
  final SpeakingP1Repository repository;

  GetS1Questions(this.repository);

  @override
  Future<Either<Failure, List<SpeakingP1Entity>>> call(Params params) async {
    return await repository.getQuestionSpeakingP1(
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
