import 'package:easyaptis/features/general_pages/speaking_page/speaking_p4/data/models/speaking_p4_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class SpeakingP4LocalDataSource {
  Future<void> cacheQuestions(List<SpeakingP4Model> questions);
  List<SpeakingP4Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class SpeakingP4LocalDataSourceImpl implements SpeakingP4LocalDataSource {
  final GenericLocalCache<SpeakingP4Model> cache;

  SpeakingP4LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<SpeakingP4Model>(
        box: box,
        key: 'speaking_p4',
        fromJson: (json) => SpeakingP4Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<SpeakingP4Model> questions) =>
      cache.cacheList(questions);

  @override
  List<SpeakingP4Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
