import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/entities/reading_p4_entity.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/repositories/reading_p4_repository.dart';
import 'package:equatable/equatable.dart';

class GetR4Questions implements UseCase<List<ReadingP4Entity>, Params> {
  final ReadingP4Repository repository;

  GetR4Questions(this.repository);

  @override
  Future<Either<Failure, List<ReadingP4Entity>>> call(Params params) async {
    return await repository.getQuestionReadingP4(
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
