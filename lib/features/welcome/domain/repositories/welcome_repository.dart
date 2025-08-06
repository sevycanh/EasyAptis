import 'package:dartz/dartz.dart';
import 'package:EasyAptis/core/error/failures.dart';

abstract class WelcomeRepository {
  Future<Either<Failure, void>> setNotFirstTime();
}