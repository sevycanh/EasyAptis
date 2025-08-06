import 'package:dartz/dartz.dart';
import 'package:EasyAptis/core/error/failures.dart';

abstract class SplashRepository {
  Future<Either<Failure, bool>> isFirstTime();
}