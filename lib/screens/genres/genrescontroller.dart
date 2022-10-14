import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GenresController extends GetxController {
  RxList selectedGenres = [].obs;
  Map genres = {
    'Action': 'assets/emoji/action.json',
    'Romance': 'assets/emoji/romance.json',
    'Drama': 'assets/emoji/drama.json',
    'Horror': 'assets/emoji/horror.json',
    'Fantasy': 'assets/emoji/fantasy.json',
    'Mistery': 'assets/emoji/mistery.json',
    'Psychological': 'assets/emoji/psychological.json',
    'Magic': 'assets/emoji/magic.json',
    'Comedy': 'assets/emoji/comedy.json',
    'Daily life': 'assets/emoji/daily-life.json',
    'Adventure': 'assets/emoji/adventure.json',
    'Thriller': 'assets/emoji/thriller.json',
  };

  void checkTag(String tag) async {
    if (selectedGenres.contains(tag)) {
      selectedGenres.remove(tag);
    } else {
      selectedGenres.add(tag);
    }
  }

  Future<void> continues() async {
    User user = FirebaseAuth.instance.currentUser!;
    DocumentReference document =
        FirebaseFirestore.instance.collection('users').doc(user.uid.toString());
    document.update({
      'genres': selectedGenres,
    });
    Get.offAllNamed('/home');
  }
}
