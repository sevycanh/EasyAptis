import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';

abstract class WelcomeRepository {
  Future<Either<Failure, void>> setNotFirstTime();
}