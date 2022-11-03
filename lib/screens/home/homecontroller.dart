import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:mangak/api/cover_art.dart';
import 'package:mangak/ulti/data.dart';
import 'package:mangak/api/manga.dart';
import 'package:mangak/ulti/manga_api.dart';
import 'package:mangak/ulti/randomuser.dart';
import 'package:mangak/api/searchfilter.dart';

class HomeController extends GetxController {
  final fireStore = Get.find<FireStoreData>();
  var dio = Dio();
  final user = FirebaseAuth.instance.currentUser;

  // late DocumentSnapshot user;
  RxBool isLoading = true.obs;
  String api = 'https://api.mangadex.org';
  Manga lsmanga = Manga();
  Map<String, String> tagMap = {
    'Action': '391b0423-d847-456f-aff0-8b0cfc03066b',
    'Adventure': '87cc87cd-a395-47af-b27a-93258283bbc6',
    'Comedy': '4d32cc48-9f00-4cca-9b5a-a839f0764984',
    'Drama': 'b9af3a63-f058-46de-a9a0-e0c13906197a',
    'Fantasy': 'cdc58593-87dd-415e-bbc0-2ec27bf404cc',
    'Romance': '423e2eae-a7a2-4a8b-ac03-a8351462d71d',
    'Historical': '33771934-028e-4cb3-8744-691e866a923e',
    'Horror': 'cdad7e68-1419-41dd-bdce-27753074a640',
    'Sci-fi': '256c8bd9-4904-4360-bf4f-508a76d67183',
  };
  RxList selectedTag = [].obs;
  Rx<TextEditingController> yearcontroller = TextEditingController().obs;
  Rx<SearchFilter> searchFilter = SearchFilter().obs;
  RxList<CoverArt> coverArt = <CoverArt>[].obs;
  List<String> coverImage = <String>[].obs;
  List<String> mangaId = <String>[].obs;
  List<String> authorId = <String>[].obs;
  List<String> artistId = <String>[].obs;
  RxList<String> coverId = <String>[].obs;
  RxList<String> title = <String>[].obs;
  List<String> authorName = <String>[].obs;
  RxList<String> year = <String>[].obs;
  RxList<String> description = <String>[].obs;
  Rx<RandomUser> randomUser = RandomUser().obs;
  RxBool isLast = true.obs;
  RxBool notContainLast = true.obs;
  Rx<String> lastCoverArt = ''.obs;
  Rx<DataManga> lastManga = DataManga().obs;
  Rx<String> lastTitle = ''.obs;
  Rx<String> lastRead = ''.obs;
  RxInt page = 0.obs;
  @override
  void onReady() async {
    super.onReady();
    await _initState();
    isLoading(false);
  }

  Future<void> fieldSearch() async {
    searchFilter.value.lang = null;
    searchFilter.value.year = null;
    searchFilter.value.status = null;
    searchFilter.value.genres.clear();
    searchFilter.value.genresId.clear();
  }

  Future<void> filterDialog() async {
    searchFilter.value.title.value = '';
    yearcontroller.value.text == ''
        ? searchFilter.value.year = null
        : searchFilter.value.year = int.parse(yearcontroller.value.text).obs;
    searchFilter.value.genres.value = [].obs;
  }

  Future<void> _initState() async {
    var mangaapi = await dio.get(
      "$api/manga?availableTranslatedLanguage[0]=vi&limit=10&contentRating[0]=safe",
    );
    if (mangaapi.statusCode == 200) {
      // print(mangaapi.data["data"]);
      lsmanga = Manga.fromJson(mangaapi.data);
      // print(manga);
    } else {
      Get.snackbar('Có lỗi khi lấy api', 'Vui lòng thử lại sau');
    }
    try {
      await getManga();
      coverImage = await MangaApi().getCoverArt(coverId);
      authorName = await MangaApi().getAuthor(authorId);
      randomUser.value = await MangaApi().getRandomUser();
      // var abc = await fireStore.getDataBase();
      // if (abc['lastRead'] == '') {
      //   isLast.value = true;
      //   notContainLast.value = true;
      // } else {
      // var coverArt = await dio.get('$api/manga/${abc['lastRead']}');
      // lastManga.value = DataManga.fromJson(coverArt.data['data']);
      // lastTitle.value = lastManga.value.attributes!.title!.en.toString();
      // lastCoverArt.value = await MangaApi().getCoverArtLast(abc['lastRead']);
      //   await 1.delay();
      //   isLast(false);
      // }
    } on DioError catch (ex) {
      Get.snackbar('Có lỗi khi lấy api', 'Quá thời gian chờ',
          snackPosition: SnackPosition.TOP);
      throw Exception(ex);
    }
  }

  Future<void> getManga() async {
    for (int i = 0; i < lsmanga.data!.length; i++) {
      year.add(lsmanga.data![i].attributes!.year.toString());
      mangaId.add(lsmanga.data![i].id!);
      // print(lsmanga.value.data![i].attributes?.description?.en);
      lsmanga.data![i].attributes?.description.toString() == 'null' ||
              lsmanga.data![i].attributes?.description?.en.toString() == 'null'
          ? description.add('Không xác định')
          : description.add(lsmanga.data![i].attributes!.description!.en!);
      lsmanga.data![i].attributes!.title!.en.toString() == 'null'
          ? title.add('Undentified')
          : title.add(lsmanga.data![i].attributes!.title!.en.toString());
      for (int j = 0; j < lsmanga.data![i].relationships!.length; j++) {
        if (lsmanga.data![i].relationships![j].type == 'author') {
          authorId.add(lsmanga.data![i].relationships![j].id!);
          // print(authorId);
        }
        if (lsmanga.data![i].relationships![j].type == 'artist') {
          artistId.add(lsmanga.data![i].relationships![j].id!);
        }
        if (lsmanga.data![i].relationships![j].type == 'cover_art') {
          coverId.add(lsmanga.data![i].relationships![j].id!);
        }
      }
    }
  }

  Future<void> onRefresh() async {
    isLoading(true);
    isLast(true);
    mangaId.clear();
    coverId.clear();
    authorId.clear();
    artistId.clear();
    coverImage.clear();
    title.clear();
    authorName.clear();
    year.clear();
    description.clear();

    await _initState();
    isLoading(false);
    isLast(false);
  }

  Future<void> checkTag(String tag) async {
    if (searchFilter.value.genres.contains(tag)) {
      searchFilter.value.genres.remove(tag);

      searchFilter.value.genresId.remove(tagMap[tag]);
    } else {
      searchFilter.value.genres.add(tag);
      searchFilter.value.genresId.add(tagMap[tag]);
    }
  }

  Future<void> clearTag() async {
    searchFilter.value.clearAll();
    yearcontroller.value.text = '';
  }

  Future<void> onFilter() async {
    searchFilter.value.lang = 'en'.obs;
    searchFilter.value.genres = [].obs;
    searchFilter.value.status = 'ongoing'.obs;
    searchFilter.value.genresId = [].obs;
  }

  Future getLast(String mangaId) async {
    var coverArt = await dio.get('$api/manga/$mangaId');
    lastManga.value = DataManga.fromJson(coverArt.data['data']);
    lastTitle.value = lastManga.value.attributes!.title!.en.toString();
    lastCoverArt.value = await MangaApi().getCoverArtLast(mangaId);
    isLast.value = false;
  }
}
