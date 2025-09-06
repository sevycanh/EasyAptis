import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/entities/listening_p1_entity.dart';

abstract class ListeningP1Repository {
  Future<Either<Failure, List<ListeningP1Entity>>> getQuestionListeningP1({
    int? page,
    int? limit,
  });
}
