import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/models/listening_p1_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class ListeningP1LocalDataSource {
  Future<void> cacheQuestions(List<ListeningP1Model> questions);
  List<ListeningP1Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class ListeningP1LocalDataSourceImpl implements ListeningP1LocalDataSource {
  final GenericLocalCache<ListeningP1Model> cache;

  ListeningP1LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<ListeningP1Model>(
        box: box,
        key: 'listening_p1',
        fromJson: (json) => ListeningP1Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<ListeningP1Model> questions) =>
      cache.cacheList(questions);

  @override
  List<ListeningP1Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
