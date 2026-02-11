import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/data/models/reading_p2vs3_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class ReadingP2vs3LocalDataSource {
  Future<void> cacheQuestions(List<ReadingP2vs3Model> questions);
  List<ReadingP2vs3Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class ReadingP2vs3LocalDataSourceImpl implements ReadingP2vs3LocalDataSource {
  final GenericLocalCache<ReadingP2vs3Model> cache;

  ReadingP2vs3LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<ReadingP2vs3Model>(
        box: box,
        key: 'reading_p2vs3',
        fromJson: (json) => ReadingP2vs3Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<ReadingP2vs3Model> questions) =>
      cache.cacheList(questions);

  @override
  List<ReadingP2vs3Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
