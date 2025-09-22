import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/data/models/listening_p1_model.dart';

abstract class ListeningP1RemoteDataSource {
  Future<List<ListeningP1Model>> getL1Questions({int? page, int? limit});
}

class ListeningP1RemoteDataSourceImpl implements ListeningP1RemoteDataSource {
  final FirebaseFirestore firestore;

  ListeningP1RemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ListeningP1Model>> getL1Questions({
    int? page,
    int? limit,
  }) async {
    try {
      CollectionReference collection = firestore
          .collection('skills')
          .doc('listening')
          .collection('parts')
          .doc('part_1')
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
                ListeningP1Model.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
