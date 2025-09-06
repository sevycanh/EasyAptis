import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/entities/reading_p1.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/repositories/reading_p1_repos.dart';
import 'package:equatable/equatable.dart';

class GetR1Questions implements UseCase<List<ReadingP1Entity>, Params> {
  final ReadingP1Repos repository;

  GetR1Questions(this.repository);

  @override
  Future<Either<Failure, List<ReadingP1Entity>>> call(Params params) async {
    return await repository.getQuestionReadingP1(
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
