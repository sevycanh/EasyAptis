import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/data/models/reading_p1_model.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class ReadingP1LocalDataSource {
  Future<void> cacheQuestions(List<ReadingP1Model> questions);
  List<ReadingP1Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class ReadingP1LocalDataSourceImpl implements ReadingP1LocalDataSource {
  final GenericLocalCache<ReadingP1Model> cache;

  ReadingP1LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<ReadingP1Model>(
        box: box,
        key: 'reading_p1',
        fromJson: (json) => ReadingP1Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<ReadingP1Model> questions) =>
      cache.cacheList(questions);

  @override
  List<ReadingP1Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
