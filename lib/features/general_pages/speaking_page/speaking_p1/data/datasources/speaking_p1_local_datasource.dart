import 'package:easyaptis/features/general_pages/speaking_page/speaking_p1/data/models/speaking_p1_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class SpeakingP1LocalDataSource {
  Future<void> cacheQuestions(List<SpeakingP1Model> questions);
  List<SpeakingP1Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class SpeakingP1LocalDataSourceImpl implements SpeakingP1LocalDataSource {
  final GenericLocalCache<SpeakingP1Model> cache;

  SpeakingP1LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<SpeakingP1Model>(
        box: box,
        key: 'speaking_p1',
        fromJson: (json) => SpeakingP1Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<SpeakingP1Model> questions) =>
      cache.cacheList(questions);

  @override
  List<SpeakingP1Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
