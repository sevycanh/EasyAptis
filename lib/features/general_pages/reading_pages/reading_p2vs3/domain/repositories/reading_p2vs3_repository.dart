import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/error/failures.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/domain/entities/reading_p2vs3_entity.dart';

abstract class ReadingP2vs3Repository {
  Future<Either<Failure, List<ReadingP2vs3Entity>>> getQuestionReadingP2vs3({
    int? page,
    int? limit,
  });
}
