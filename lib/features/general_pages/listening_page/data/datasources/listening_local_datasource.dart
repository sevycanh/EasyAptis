import 'dart:io';
import 'package:easyaptis/core/cache/generic_file_cache.dart';

abstract class ListeningCacheLocalDataSource {
  /// Return local File if exists (and valid), otherwise null
  Future<File?> getCachedAudio(String url);

  /// Ensure file cached and return local File (download if missing)
  Future<File> cacheAudio(String url);

  /// Clear whole audio cache (optional)
  Future<void> clearAudioCache();
}


class ListeningCacheLocalDataSourceImpl implements ListeningCacheLocalDataSource {
  final GenericFileCache fileCache;

  ListeningCacheLocalDataSourceImpl({required this.fileCache});

  @override
  Future<File> cacheAudio(String url) => fileCache.getOrDownload(url);

  @override
  Future<File?> getCachedAudio(String url) => fileCache.getFileIfValid(url);

  @override
  Future<void> clearAudioCache() => fileCache.clearAll();
}
