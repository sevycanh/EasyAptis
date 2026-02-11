import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox('reading_p1_box');
    await Hive.openBox('reading_p2_box');
    await Hive.openBox('listening_p1_box');
    await Hive.openBox('listening_p2_box');
  }

  static Box getBox(String name) => Hive.box(name);
}
