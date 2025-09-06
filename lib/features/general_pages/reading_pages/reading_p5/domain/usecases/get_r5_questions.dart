import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/entities/reading_p5_entity.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/repositories/reading_p5_repository.dart';
import 'package:equatable/equatable.dart';

class GetR5Questions implements UseCase<List<ReadingP5Entity>, Params> {
  final ReadingP5Repository repository;

  GetR5Questions(this.repository);

  @override
  Future<Either<Failure, List<ReadingP5Entity>>> call(Params params) async {
    return await repository.getQuestionReadingP5(
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
