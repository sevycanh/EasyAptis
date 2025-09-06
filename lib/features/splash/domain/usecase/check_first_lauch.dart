import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/core/utils/usecases/usecase.dart';
import 'package:easyaptis/features/splash/domain/repositories/splash_repository.dart';

class CheckFirstLaunch implements UseCase<bool, NoParams> {
  final SplashRepository repository;

  CheckFirstLaunch(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.isFirstTime();
  }
}
