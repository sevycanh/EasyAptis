import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/domain/entities/speaking_p2_entity.dart';

abstract class SpeakingP2Repository {
  Future<Either<Failure, List<SpeakingP2Entity>>> getQuestionSpeakingP2({
    int? page,
    int? limit,
  });
}
