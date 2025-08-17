import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyaptis/core/configs/error/exceptions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/data/models/reading_p2vs3_model.dart';

abstract class ReadingP2vs3RemoteDataSource {
  Future<List<ReadingP2vs3Model>> getR2vs3Questions({int? page, int? limit});
}

class ReadingP2vs3RemoteDataSourceImpl implements ReadingP2vs3RemoteDataSource {
  final FirebaseFirestore firestore;

  ReadingP2vs3RemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ReadingP2vs3Model>> getR2vs3Questions({
    int? page,
    int? limit,
  }) async {
    try {
      CollectionReference collection = firestore
          .collection('skills')
          .doc('reading')
          .collection('parts')
          .doc('part_2vs3')
          .collection('questions');

      Query query = collection.orderBy('index');

      if (page != null && limit != null) {
        int startIndex = (page - 1) * limit;
        query = query.startAt([startIndex + 1]).limit(limit);
      } else if (limit != null) {
        query = query.limit(limit);
      }

      QuerySnapshot snapshot = await query.get();

      return snapshot.docs
          .map(
            (doc) =>
                ReadingP2vs3Model.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
