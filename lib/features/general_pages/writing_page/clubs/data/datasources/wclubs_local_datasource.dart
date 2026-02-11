import 'package:easyaptis/core/cache/generic_local_cache.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/data/models/wclubs_model.dart';
import 'package:hive/hive.dart';

abstract class WClubsLocalDataSource {
  Future<void> cacheQuestions(List<WClubsModel> questions);
  List<WClubsModel>? getCachedQuestions({Duration? maxAge});
  Future<void> clearCache();
}

class WClubsLocalDataSourceImpl implements WClubsLocalDataSource {
  final GenericLocalCache<WClubsModel> cache;

  WClubsLocalDataSourceImpl(Box box)
    : cache = GenericLocalCache<WClubsModel>(
        box: box,
        key: 'writing',
        fromJson: (json) => WClubsModel.fromJson(json),
        toJson: (obj) => obj.toJson(),
      );

  @override
  Future<void> cacheQuestions(List<WClubsModel> questions) =>
      cache.cacheList(questions);

  @override
  List<WClubsModel>? getCachedQuestions({Duration? maxAge}) =>
      cache.getCachedList(maxAge: maxAge);

  @override
  Future<void> clearCache() => cache.clear();
}
