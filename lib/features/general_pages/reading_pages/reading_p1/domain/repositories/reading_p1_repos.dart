import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/error/failures.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/domain/entities/reading_p1.dart';

abstract class ReadingP1Repos {
  Future<Either<Failure, List<ReadingP1Entity>>> getQuestionReadingP1({
    int? page,
    int? limit,
  });
}
