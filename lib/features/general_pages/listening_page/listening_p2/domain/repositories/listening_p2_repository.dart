import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/domain/entities/listening_p2_entity.dart';

abstract class ListeningP2Repository {
  Future<Either<Failure, List<ListeningP2Entity>>> getQuestionListeningP2({
    int? page,
    int? limit,
  });
}
