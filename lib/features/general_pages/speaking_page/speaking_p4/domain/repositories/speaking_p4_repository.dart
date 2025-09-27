import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/domain/entities/speaking_p4_entity.dart';

abstract class SpeakingP4Repository {
  Future<Either<Failure, List<SpeakingP4Entity>>> getQuestionSpeakingP4({
    int? page,
    int? limit,
  });
}
