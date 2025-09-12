import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/domain/entities/listening_p3_entity.dart';

abstract class ListeningP3Repository {
  Future<Either<Failure, List<ListeningP3Entity>>> getQuestionListeningP3({
    int? page,
    int? limit,
  });
}
