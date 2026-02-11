import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class GenericLocalCache<T> {
  final Box box;
  final String key;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  GenericLocalCache({
    required this.box,
    required this.key,
    required this.fromJson,
    required this.toJson,
  });

  Future<void> cacheList(List<T> data) async {
    await box.put(key, jsonEncode(data.map(toJson).toList()));
    await box.put('${key}_ts', DateTime.now().toIso8601String());
  }

  List<T>? getCachedList({Duration? maxAge}) {
    final jsonString = box.get(key);
    final ts = box.get('${key}_ts') as String?;
    if (jsonString == null || ts == null) return null;

    if (maxAge != null) {
      final saved = DateTime.parse(ts);
      if (DateTime.now().difference(saved) > maxAge) {
        return null;
      }
    }

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> clear() async {
    await box.delete(key);
    await box.delete('${key}_ts');
  }
}
