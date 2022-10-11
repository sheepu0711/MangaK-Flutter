import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mangak/api/author.dart';
import 'package:mangak/api/cover_art.dart';
import 'package:mangak/api/mangaid.dart';
import 'package:mangak/api/manga.dart';
import 'package:mangak/ulti/randomuser.dart';
import 'package:mangak/api/searchfilter.dart';

var dio = Dio();
String api = 'https://api.mangadex.org';

class MangaApi extends GetxController {
  Future getCoverArtLast(String mangaId) async {
    var coverArtId = await getCoverArtId(mangaId);
    var coverart = await dio.get("$api/cover/$coverArtId");
    var cover = CoverArt.fromJson(coverart.data);
    String coverurl = cover.data!.attributes!.fileName!;
    return 'https://uploads.mangadex.org/covers/${cover.data!.relationships![0].id}/$coverurl';
  }

  Future getCoverArtId(String mangaId) async {
    var coverArt = await dio.get('$api/manga/$mangaId');
    var coverArtId = DataManga.fromJson(coverArt.data['data']);
    for (int i = 0; i < coverArtId.relationships!.length; i++) {
      if (coverArtId.relationships![i].type == 'cover_art') {
        return coverArtId.relationships![i].id;
      }
    }
  }

  Future getManga(String mangaId) async {
    var mangaApi = await dio.get(
      "$api/manga/$mangaId",
    );
    DataManga manga = DataManga.fromJson(mangaApi.data['data']);
    return manga;
  }

  Future<List<String>> getCoverArt(
    List coverId,
  ) async {
    RxList<String> coverImage = <String>[].obs;
    for (int j = 0; j < coverId.length; j++) {
      var coverart = await dio.get("$api/cover/${coverId[j]}");
      var cover = CoverArt.fromJson(coverart.data);
      String coverurl = cover.data!.attributes!.fileName!;
      coverImage.add(
          'https://uploads.mangadex.org/covers/${cover.data!.relationships![0].id}/$coverurl');
    }
    return coverImage;
  }

  Future<List<String>> getAuthor(List authorId) async {
    RxList<String> authorName = <String>[].obs;

    for (int i = 0; i < authorId.length; i++) {
      var authorapi = await dio.get("$api/author/${authorId[i]}");
      var author = Author.fromJson(authorapi.data);
      // print(authorName);
      authorName.add(author.data!.attributes!.name!);
      // print(author.data!.attributes!.name!);
    }
    return authorName;
  }

  Future<RandomUser> getRandomUser() async {
    var userapi = await dio.get(
      "https://randomuser.me/api/?results=10",
    );
    RandomUser user = RandomUser.fromJson(userapi.data);
    return user;
  }

  Future<MangaId> getId(Manga manga) async {
    MangaId mangaId = MangaId();
    for (int i = 0; i < manga.data!.length; i++) {
      for (int j = 0; j < manga.data![i].relationships!.length; j++) {
        if (manga.data![i].relationships![j].type == 'author') {
          mangaId.authorId.add(manga.data![i].relationships![j].id!);
        }
        if (manga.data![i].relationships![j].type == 'cover_art') {
          mangaId.coverId.add(manga.data![i].relationships![j].id!);
        }
        if (manga.data![i].relationships![j].type == 'artist') {
          mangaId.artistId.add(manga.data![i].relationships![j].id!);
        }
      }
      mangaId.id.add(manga.data![i].id!);
      if (manga.data![i].attributes!.title!.en != null) {
        mangaId.title.add(manga.data![i].attributes!.title!.en!);
      } else {
        mangaId.title.add('No Title');
      }
    }
    return mangaId;
  }

  Future<Object?> getUserDataBase() async {
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(user.uid.toString()).get();
    return documentSnapshot.data();
  }

  toDetail(
      {required DataManga manga,
      required String cover,
      required String author}) {
    Get.toNamed("/mangadetail", arguments: {
      'manga': manga,
      'cover': cover,
      'author': author,
    });
  }

  toProfile(
      {required String username,
      required String name,
      required String avatar}) {
    Get.toNamed("/profile", arguments: {
      'username': username,
      'name': name,
      'avatar': avatar,
    });
  }

  toSearch({required SearchFilter searchFilter}) {
    Get.toNamed("/search", arguments: searchFilter);
  }
}
