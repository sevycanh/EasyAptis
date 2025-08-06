import 'package:EasyAptis/core/configs/constants/app_constant.dart';
import 'package:EasyAptis/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SplashSharedPrefs {
  Future<bool> isFirstTime();
}

class SplashSharedPrefsImpl implements SplashSharedPrefs {
  final SharedPreferences sharedPreferences;

  SplashSharedPrefsImpl({required this.sharedPreferences});

  @override
  Future<bool> isFirstTime() async {
    try {
      return sharedPreferences.getBool(
            AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME,
          ) ??
          true;
    } catch (e) {
      throw CacheException();
    }
  }
}
