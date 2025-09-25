import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/domain/entities/speaking_p1_entity.dart';

abstract class SpeakingP1Repository {
  Future<Either<Failure, List<SpeakingP1Entity>>> getQuestionSpeakingP1({
    int? page,
    int? limit,
  });
}
