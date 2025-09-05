import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/error/failures.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/domain/entities/reading_p5_entity.dart';

abstract class ReadingP5Repository {
  Future<Either<Failure, List<ReadingP5Entity>>> getQuestionReadingP5({
    int? page,
    int? limit,
  });
}
