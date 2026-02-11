import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/data/models/speaking_p2_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class SpeakingP2LocalDataSource {
  Future<void> cacheQuestions(List<SpeakingP2Model> questions);
  List<SpeakingP2Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class SpeakingP2LocalDataSourceImpl implements SpeakingP2LocalDataSource {
  final GenericLocalCache<SpeakingP2Model> cache;

  SpeakingP2LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<SpeakingP2Model>(
        box: box,
        key: 'speaking_p2',
        fromJson: (json) => SpeakingP2Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<SpeakingP2Model> questions) =>
      cache.cacheList(questions);

  @override
  List<SpeakingP2Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
