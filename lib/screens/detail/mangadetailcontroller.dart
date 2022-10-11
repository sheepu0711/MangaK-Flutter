import 'package:firebase_auth/firebase_auth.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:mangak/ulti/data.dart';
import 'package:mangak/api/feed.dart';
import 'package:mangak/api/manga.dart';

class DetailController extends GetxController {
  final fireStore = Get.find<FireStoreData>();
  final user = FirebaseAuth.instance.currentUser!;
  var dio = Dio();
  var mangaId = "".obs;
  var mangaTitle = "".obs;
  var mangaCover = "".obs;
  var mangaAuthor = "".obs;
  var mangaYear = "".obs;
  var mangaDescription = "".obs;
  Rx<Feed> lsFeed = Feed().obs;
  Rx<DataManga> ls = DataManga().obs;
  RxBool isLoading = true.obs;
  RxList favorites = [].obs;
  @override
  void onInit() async {
    ls.value = Get.arguments['manga'];
    // print(ls.runtimeType);
    mangaId.value = ls.value.id!;
    mangaTitle.value = ls.value.attributes!.title?.en ?? "No title";
    mangaCover.value = Get.arguments['cover'];
    mangaAuthor.value = Get.arguments['author'];
    mangaYear.value = ls.value.attributes!.year.toString() == 'null'
        ? "No year"
        : ls.value.attributes!.year.toString();
    // print(mangaYear.value);
    mangaDescription.value =
        ls.value.attributes!.description?.en ?? "No description";

    super.onInit();
    await fireStore.addLast(mangaId.value);
    var test = await fireStore.getDataBase();
    favorites.value = test['favorites'];
    await getChapter();
  }

  Future<void> getChapter() async {
    // print(mangaId);
    var chapterapi = await dio.get(
      "https://api.mangadex.org/manga/$mangaId/feed",
    );
    if (chapterapi.statusCode == 200) {
      var feed = Feed.fromJson(chapterapi.data);
      lsFeed = Feed(
              result: feed.result,
              response: feed.response,
              data: feed.data,
              limit: feed.limit,
              offset: feed.offset,
              total: feed.total)
          .obs;
      // print(lsFeed.value.data!.length);
      for (int i = 0; i < lsFeed.value.data!.length; i++) {
        if (lsFeed.value.data![i].attributes!.pages == 0 ||
            lsFeed.value.data![i].attributes!.chapter == null) {
          lsFeed.value.data!.removeAt(i);
        }
      }
      var abc = <dynamic>{};
      lsFeed.value.data!
          .retainWhere((element) => abc.add(element.attributes!.chapter));

      lsFeed.value.data!.sort((a, b) => compareNatural(a.attributes!.chapter!,
          b.attributes!.chapter!)); // sort chapters from newest to oldest
      // print(lsFeed.value.data![0].attributes!.chapter);
      // for (int i = 0; i < lsFeed.value.data!.length; i++) {
      //   print(lsFeed.value.data![i].attributes!.chapter);
      // }
      // print(lsFeed.value.data![0].id);
      // print(lsFeed.value.data![0].attributes!.chapter);
      // print(abc);
      isLoading(false);
    } else {
      Get.snackbar('Có lỗi khi lấy api', 'Vui lòng thử lại sau');
    }
  }

  Future<void> checkFavorite() async {
    // print(favorites.contains(mangaId.value));
    if (favorites.contains(mangaId.value)) {
      await fireStore.removeFavorite(mangaId.value);
    } else {
      await fireStore.addFavorite(mangaId.value);
    }
  }
}
