import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p2/data/models/listening_p2_model.dart';

abstract class ListeningP2RemoteDataSource {
  Future<List<ListeningP2Model>> getL2Questions({int? page, int? limit});
}

class ListeningP2RemoteDataSourceImpl implements ListeningP2RemoteDataSource {
  final FirebaseFirestore firestore;

  ListeningP2RemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ListeningP2Model>> getL2Questions({
    int? page,
    int? limit,
  }) async {
    try {
      CollectionReference collection = firestore
          .collection('skills')
          .doc('listening')
          .collection('parts')
          .doc('part_2')
          .collection('questions');

      Query query = collection.orderBy('index');

      if (page != null && limit != null) {
        int startIndex = (page - 2) * limit;
        query = query.startAt([startIndex + 2]).limit(limit);
      } else if (limit != null) {
        query = query.limit(limit);
      }

      QuerySnapshot snapshot = await query.get();

      return snapshot.docs
          .map(
            (doc) =>
                ListeningP2Model.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
