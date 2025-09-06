import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/data/models/reading_p5_model.dart';

abstract class ReadingP5RemoteDataSource {
  Future<List<ReadingP5Model>> getR5Questions({int? page, int? limit});
}

class ReadingP5RemoteDataSourceImpl implements ReadingP5RemoteDataSource {
  final FirebaseFirestore firestore;

  ReadingP5RemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ReadingP5Model>> getR5Questions({
    int? page,
    int? limit,
  }) async {
    try {
      CollectionReference collection = firestore
          .collection('skills')
          .doc('reading')
          .collection('parts')
          .doc('part_5')
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
                ReadingP5Model.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
