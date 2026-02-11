import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/data/models/reading_p4_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class ReadingP4LocalDataSource {
  Future<void> cacheQuestions(List<ReadingP4Model> questions);
  List<ReadingP4Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class ReadingP4LocalDataSourceImpl implements ReadingP4LocalDataSource {
  final GenericLocalCache<ReadingP4Model> cache;

  ReadingP4LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<ReadingP4Model>(
        box: box,
        key: 'reading_p4',
        fromJson: (json) => ReadingP4Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<ReadingP4Model> questions) =>
      cache.cacheList(questions);

  @override
  List<ReadingP4Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
