import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FireStoreData extends GetxService {
  static User user = FirebaseAuth.instance.currentUser!;
  DocumentReference document =
      FirebaseFirestore.instance.collection('users').doc(user.uid.toString());

  Future<void> updateAvatar(String url) async {
    user.updatePhotoURL(url);
  }

  Future addFavorite(String mangaId) async {
    document.update({
      'favorites': FieldValue.arrayUnion([mangaId]),
    });
  }

  Future removeFavorite(String mangaId) async {
    document.update({
      'favorites': FieldValue.arrayRemove([mangaId]),
    });
  }

  Future addLast(String mangaId) async {
    document.update({
      'lastRead': mangaId,
    });
  }

  Future<Map<String, dynamic>> getDataBase() async {
    FirebaseAuth instance = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var user = await firestore
        .collection('users')
        .doc(instance.currentUser!.uid.toString())
        .get();

    return user.data()!;
  }
}
