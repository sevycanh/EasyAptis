import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/domain/entities/speaking_p3_entity.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/domain/repositories/speaking_p3_repository.dart';
import 'package:equatable/equatable.dart';

class GetS3Questions implements UseCase<List<SpeakingP3Entity>, Params> {
  final SpeakingP3Repository repository;

  GetS3Questions(this.repository);

  @override
  Future<Either<Failure, List<SpeakingP3Entity>>> call(Params params) async {
    return await repository.getQuestionSpeakingP3(
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
