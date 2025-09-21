import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyaptis/core/error/exceptions.dart';
import 'package:easyaptis/features/general_pages/writing_page/club_details/data/models/topic_model.dart';

abstract class WClubsDetailRemoteDataSource {
  Future<TopicModel> getDetailOfClub({required int clubId});
}

class WClubsDetailRemoteDataSourceImpl implements WClubsDetailRemoteDataSource {
  final FirebaseFirestore firestore;

  WClubsDetailRemoteDataSourceImpl({required this.firestore});

  @override
  Future<TopicModel> getDetailOfClub({required int clubId}) async {
    try {
      final querySnapshot =
          await firestore
              .collection("skills")
              .doc("writing")
              .collection("topics")
              .where("id", isEqualTo: clubId)
              .limit(1)
              .get();

      final data = querySnapshot.docs.first.data();
      return TopicModel.fromJson(data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
