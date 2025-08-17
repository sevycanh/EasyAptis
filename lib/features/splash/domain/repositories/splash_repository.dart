import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/error/failures.dart';

abstract class SplashRepository {
  Future<Either<Failure, bool>> isFirstTime();
}