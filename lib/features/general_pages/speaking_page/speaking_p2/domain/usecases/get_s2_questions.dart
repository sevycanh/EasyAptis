import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/domain/entities/speaking_p2_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/domain/repositories/speaking_p2_repository.dart';
import 'package:equatable/equatable.dart';

class GetS2Questions implements UseCase<List<SpeakingP2Entity>, Params> {
  final SpeakingP2Repository repository;

  GetS2Questions(this.repository);

  @override
  Future<Either<Failure, List<SpeakingP2Entity>>> call(Params params) async {
    return await repository.getQuestionSpeakingP2(
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
