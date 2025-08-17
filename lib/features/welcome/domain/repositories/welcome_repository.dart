import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/error/failures.dart';

abstract class WelcomeRepository {
  Future<Either<Failure, void>> setNotFirstTime();
}