import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/shared/file_cache/repositories/file_cache_repository.dart';

class GetCachedFile {
  final FileCacheRepository repository;
  GetCachedFile(this.repository);

  Future<Either<Failure, File>> call({required String url, required String type}) {
    return repository.getCachedFile(url, type: type);
  }
}
