import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/domain/entities/reading_p4_entity.dart';

abstract class ReadingP4Repository {
  Future<Either<Failure, List<ReadingP4Entity>>> getQuestionReadingP4({
    int? page,
    int? limit,
  });
}
