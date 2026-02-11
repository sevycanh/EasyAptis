import 'package:easyaptis/features/general_pages/speaking_page/speaking_p3/data/models/speaking_p3_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class SpeakingP3LocalDataSource {
  Future<void> cacheQuestions(List<SpeakingP3Model> questions);
  List<SpeakingP3Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class SpeakingP3LocalDataSourceImpl implements SpeakingP3LocalDataSource {
  final GenericLocalCache<SpeakingP3Model> cache;

  SpeakingP3LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<SpeakingP3Model>(
        box: box,
        key: 'speaking_p3',
        fromJson: (json) => SpeakingP3Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<SpeakingP3Model> questions) =>
      cache.cacheList(questions);

  @override
  List<SpeakingP3Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
