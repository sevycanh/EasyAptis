import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyaptis/core/configs/error/exceptions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/data/models/reading_p4_model.dart';

abstract class ReadingP4RemoteDataSource {
  Future<List<ReadingP4Model>> getR4Questions({int? page, int? limit});
}

class ReadingP4RemoteDataSourceImpl implements ReadingP4RemoteDataSource {
  final FirebaseFirestore firestore;

  ReadingP4RemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ReadingP4Model>> getR4Questions({
    int? page,
    int? limit,
  }) async {
    try {
      CollectionReference collection = firestore
          .collection('skills')
          .doc('reading')
          .collection('parts')
          .doc('part_4')
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
                ReadingP4Model.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
