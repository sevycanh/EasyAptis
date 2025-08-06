import 'package:dartz/dartz.dart';
import 'package:EasyAptis/core/error/failures.dart';
import 'package:EasyAptis/core/utils/usecases/usecase.dart';
import 'package:EasyAptis/features/welcome/domain/repositories/welcome_repository.dart';

class SetNotFirstLaunch implements UseCase<void, NoParams> {
  final WelcomeRepository repository;

  SetNotFirstLaunch(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.setNotFirstTime();
  }
}
