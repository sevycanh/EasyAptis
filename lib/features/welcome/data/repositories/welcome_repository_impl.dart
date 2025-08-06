import 'package:dartz/dartz.dart';
import 'package:EasyAptis/core/error/exceptions.dart';
import 'package:EasyAptis/core/error/failures.dart';
import 'package:EasyAptis/features/welcome/data/sources/local/welcome_shared_prefs.dart';
import 'package:EasyAptis/features/welcome/domain/repositories/welcome_repository.dart';

class WelcomeRepositoryImpl implements WelcomeRepository {
  final WelcomeSharedPrefs preferences;
  WelcomeRepositoryImpl(this.preferences);
  @override
  Future<Either<Failure, void>> setNotFirstTime() async {
    try {
      await preferences.setNotFirstLaunch();
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
