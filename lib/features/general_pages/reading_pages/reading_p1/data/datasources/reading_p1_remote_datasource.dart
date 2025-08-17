import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyaptis/core/configs/error/exceptions.dart';

import '../models/reading_p1_model.dart';

abstract class ReadingP1RemoteDataSource {
  Future<List<ReadingP1Model>> getR1Questions({int? page, int? limit});
}

class ReadingP1RemoteDataSourceImpl implements ReadingP1RemoteDataSource {
  final FirebaseFirestore firestore;

  ReadingP1RemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ReadingP1Model>> getR1Questions({int? page, int? limit}) async {
    try {
      CollectionReference collection = firestore
          .collection('skills')
          .doc('reading')
          .collection('parts')
          .doc('part_1')
          .collection('questions');

      Query query = collection.orderBy('index');

      if (page != null && limit != null) {
        int startIndex = (page - 1) * limit;
        query = query.startAt([startIndex + 1]).limit(limit);
      } else if (limit != null && page == null) {
        query = query.limit(limit);
      } else if (page != null && limit == null) {
        query = query.startAt([101]);
      }

      QuerySnapshot snapshot = await query.get();

      return snapshot.docs
          .map(
            (doc) =>
                ReadingP1Model.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
