import 'package:easyaptis/features/general_pages/listening_page/listening_p2/data/models/listening_p2_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easyaptis/core/cache/generic_local_cache.dart';

abstract class ListeningP2LocalDataSource {
  Future<void> cacheQuestions(List<ListeningP2Model> questions);
  List<ListeningP2Model>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class ListeningP2LocalDataSourceImpl implements ListeningP2LocalDataSource {
  final GenericLocalCache<ListeningP2Model> cache;

  ListeningP2LocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<ListeningP2Model>(
        box: box,
        key: 'listening_p2',
        fromJson: (json) => ListeningP2Model.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<ListeningP2Model> questions) =>
      cache.cacheList(questions);

  @override
  List<ListeningP2Model>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
