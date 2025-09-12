import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p4/domain/entities/listening_p4_entity.dart';

abstract class ListeningP4Repository {
  Future<Either<Failure, List<ListeningP4Entity>>> getQuestionListeningP4({
    int? page,
    int? limit,
  });
}
