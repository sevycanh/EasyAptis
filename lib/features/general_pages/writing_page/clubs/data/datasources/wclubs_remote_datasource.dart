import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/features/general_pages/writing_page/clubs/data/models/wclubs_model.dart';

abstract class WClubsRemoteDataSource {
  Future<List<WClubsModel>> getListOfClubs({int? page, int? limit});
}

class WClubsRemoteDataSourceImpl implements WClubsRemoteDataSource {
  final FirebaseFirestore firestore;

  WClubsRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<WClubsModel>> getListOfClubs({
    int? page,
    int? limit,
  }) async {
    try {
      CollectionReference collection = firestore
          .collection('skills')
          .doc('writing')
          .collection('topics');

      Query query = collection.orderBy('id');

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
                WClubsModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
