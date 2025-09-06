import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/splash/data/sources/local/splash_shared_prefs.dart';
import 'package:easyaptis/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashSharedPrefs preferences;

  SplashRepositoryImpl(this.preferences);

  @override
  Future<Either<Failure, bool>> isFirstTime() async {
    try {
      return Right(await preferences.isFirstTime());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
