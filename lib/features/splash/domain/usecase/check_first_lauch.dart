import 'package:dartz/dartz.dart';
import 'package:EasyAptis/core/error/failures.dart';
import 'package:EasyAptis/core/utils/usecases/usecase.dart';
import 'package:EasyAptis/features/splash/domain/repositories/splash_repository.dart';

class CheckFirstLaunch implements UseCase<bool, NoParams> {
  final SplashRepository repository;

  CheckFirstLaunch(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.isFirstTime();
  }
}
