import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/features/general_pages/speaking_page/speaking_p2/data/models/speaking_p2_model.dart';

abstract class SpeakingP2RemoteDataSource {
  Future<List<SpeakingP2Model>> getS2Questions({int? page, int? limit});
}

class SpeakingP2RemoteDataSourceImpl implements SpeakingP2RemoteDataSource {
  final FirebaseFirestore firestore;

  SpeakingP2RemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<SpeakingP2Model>> getS2Questions({
    int? page,
    int? limit,
  }) async {
    try {
      CollectionReference collection = firestore
          .collection('skills')
          .doc('speaking')
          .collection('parts')
          .doc('part_2')
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
                SpeakingP2Model.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
