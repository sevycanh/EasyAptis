import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/core/error/failures.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/datasources/listening_p1_local_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/datasources/listening_p1_remote_datasource.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/domain/entities/listening_p1_entity.dart';
import '../../domain/repositories/listening_p1_repository.dart';

class ListeningP1RepositoryImpl implements ListeningP1Repository {
  final ListeningP1RemoteDataSource remoteDataSource;
  final ListeningP1LocalDataSource localDataSource;
  final Duration cacheMaxAge;

  ListeningP1RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    this.cacheMaxAge = const Duration(
      days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
    ),
  });

  @override
  Future<Either<Failure, List<ListeningP1Entity>>> getQuestionListeningP1({
    int? page,
    int? limit,
    bool forceRefresh = false,
  }) async {
    try {
      final cached = localDataSource.getCachedQuestions(maxAge: cacheMaxAge);

      if (cached != null && cached.isNotEmpty && !forceRefresh) {
        return Right(cached.map((m) => m.toEntity()).toList());
      }

      final result = await remoteDataSource.getL1Questions(
        page: page,
        limit: limit,
      );
      await localDataSource.cacheQuestions(result);
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

// class ListeningP1RepositoryImpl implements ListeningP1Repository {
//   final ListeningP1RemoteDataSource remoteDataSource;
//   final ListeningCacheLocalDataSource cacheDataSource;

//   ListeningP1RepositoryImpl({
//     required this.remoteDataSource,
//     required this.cacheDataSource,
//   });

//   @override
//   Future<Either<Failure, List<ListeningP1Entity>>> getQuestionListeningP1({
//     int? page,
//     int? limit,
//   }) async {
//     try {
//       final result = await remoteDataSource.getL1Questions(page: page, limit: limit);
//       // optional: prefetch audio (non-blocking)
//       for (final m in result) {
//         final url = m.audioUrl;
//         // kick off cache (don't await if you want faster response)
//         unawaited(cacheDataSource.cacheAudio(url));
//       }
//       return Right(result.map((m) => m.toEntity()).toList());
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message));
//     }
//   }
// }
