import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p3/data/models/listening_p3_model.dart';

abstract class ListeningP3RemoteDataSource {
  Future<List<ListeningP3Model>> getL3Questions({int? page, int? limit});
}

class ListeningP3RemoteDataSourceImpl implements ListeningP3RemoteDataSource {
  final FirebaseFirestore firestore;

  ListeningP3RemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ListeningP3Model>> getL3Questions({
    int? page,
    int? limit,
  }) async {
    try {
      CollectionReference collection = firestore
          .collection('skills')
          .doc('listening')
          .collection('parts')
          .doc('part_3')
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
                ListeningP3Model.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
