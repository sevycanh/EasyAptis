import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/domain/entities/speaking_p4_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/domain/repositories/speaking_p4_repository.dart';
import 'package:equatable/equatable.dart';

class GetS4Questions implements UseCase<List<SpeakingP4Entity>, Params> {
  final SpeakingP4Repository repository;

  GetS4Questions(this.repository);

  @override
  Future<Either<Failure, List<SpeakingP4Entity>>> call(Params params) async {
    return await repository.getQuestionSpeakingP4(
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
