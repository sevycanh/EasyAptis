import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/listening_page/data/datasources/listening_local_datasource.dart';

abstract class FileCacheRepository {
  Future<Either<Failure, File>> getCachedFile(String url, {required String type});
}

class FileCacheRepositoryImpl implements FileCacheRepository {
  final ListeningCacheLocalDataSource listeningCache;
  // final SpeakingCacheLocalDataSource speakingCache;

  FileCacheRepositoryImpl({
    required this.listeningCache,
    // required this.speakingCache,
  });

  @override
  Future<Either<Failure, File>> getCachedFile(String url, {required String type}) async {
    try {
      if (type == 'audio') {
        final file = await listeningCache.getCachedAudio(url);
        if (file != null) return Right(file);
        final downloaded = await listeningCache.cacheAudio(url);
        return Right(downloaded);
      } 
      // else if (type == 'image') {
        // final file = await speakingCache.getCachedImage(url);
        // if (file != null) return Right(file);
        // final downloaded = await speakingCache.cacheImage(url);
        // return Right(downloaded);
      // } 
      else {
        return Left(CacheFailure('Unsupported type $type'));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}