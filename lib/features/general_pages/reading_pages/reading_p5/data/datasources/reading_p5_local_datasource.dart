import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/data/models/reading_p5_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class ReadingP5LocalDataSource {
  Future<void> cacheQuestions(List<ReadingP5Model> questions);
  List<ReadingP5Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class ReadingP5LocalDataSourceImpl implements ReadingP5LocalDataSource {
  final GenericLocalCache<ReadingP5Model> cache;

  ReadingP5LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<ReadingP5Model>(
        box: box,
        key: 'reading_p5',
        fromJson: (json) => ReadingP5Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<ReadingP5Model> questions) =>
      cache.cacheList(questions);

  @override
  List<ReadingP5Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
