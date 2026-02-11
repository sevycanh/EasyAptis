import 'package:easyaptis/features/general_pages/listening_page/listening_p3/data/models/listening_p3_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class ListeningP3LocalDataSource {
  Future<void> cacheQuestions(List<ListeningP3Model> questions);
  List<ListeningP3Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class ListeningP3LocalDataSourceImpl implements ListeningP3LocalDataSource {
  final GenericLocalCache<ListeningP3Model> cache;

  ListeningP3LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<ListeningP3Model>(
        box: box,
        key: 'listening_p3',
        fromJson: (json) => ListeningP3Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<ListeningP3Model> questions) =>
      cache.cacheList(questions);

  @override
  List<ListeningP3Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
