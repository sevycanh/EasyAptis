import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';

abstract class SplashRepository {
  Future<Either<Failure, bool>> isFirstTime();
}