import 'package:easyaptis/features/general_pages/listening_page/listening_p4/data/models/listening_p4_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class ListeningP4LocalDataSource {
  Future<void> cacheQuestions(List<ListeningP4Model> questions);
  List<ListeningP4Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class ListeningP4LocalDataSourceImpl implements ListeningP4LocalDataSource {
  final GenericLocalCache<ListeningP4Model> cache;

  ListeningP4LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<ListeningP4Model>(
        box: box,
        key: 'listening_p4',
        fromJson: (json) => ListeningP4Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<ListeningP4Model> questions) =>
      cache.cacheList(questions);

  @override
  List<ListeningP4Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
