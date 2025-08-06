import 'package:EasyAptis/core/configs/constants/app_constant.dart';
import 'package:EasyAptis/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class WelcomeSharedPrefs {
  Future<void> setNotFirstLaunch();
}

class WelcomeSharedPrefsImpl implements WelcomeSharedPrefs {
  final SharedPreferences sharedPreferences;

  WelcomeSharedPrefsImpl({required this.sharedPreferences});
  @override
  Future<void> setNotFirstLaunch() async {
    try {
      await sharedPreferences.setBool(
        AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME,
        false,
      );
    } catch (e) {
      throw CacheException();
    }
  }
}