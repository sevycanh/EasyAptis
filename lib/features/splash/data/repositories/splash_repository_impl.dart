import 'package:dartz/dartz.dart';
import 'package:EasyAptis/core/error/exceptions.dart';
import 'package:EasyAptis/core/error/failures.dart';
import 'package:EasyAptis/features/splash/data/sources/local/splash_shared_prefs.dart';
import 'package:EasyAptis/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashSharedPrefs preferences;

  SplashRepositoryImpl(this.preferences);

  @override
  Future<Either<Failure, bool>> isFirstTime() async {
    try {
      return Right(await preferences.isFirstTime());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

}
