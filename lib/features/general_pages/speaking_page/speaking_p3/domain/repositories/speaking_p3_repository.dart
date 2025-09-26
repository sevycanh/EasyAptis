import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/domain/entities/speaking_p3_entity.dart';

abstract class SpeakingP3Repository {
  Future<Either<Failure, List<SpeakingP3Entity>>> getQuestionSpeakingP3({
    int? page,
    int? limit,
  });
}
