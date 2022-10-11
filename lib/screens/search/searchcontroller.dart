import 'package:get/get.dart';
import 'package:mangak/api/manga.dart';
import 'package:mangak/ulti/manga_api.dart';
import 'package:mangak/api/mangaid.dart';
import 'package:mangak/api/searchfilter.dart';
import 'package:dio/dio.dart';

var dio = Dio();

class SearchController extends GetxController {
  SearchFilter searchFilter = Get.arguments;
  Rx<Manga> mangars = Manga().obs;
  List<String> coverImageRs = <String>[];
  List<String> authorNameRs = <String>[];
  List<String> coverId = <String>[];
  List<String> authorId = <String>[];
  MangaId mangaId = MangaId();
  String api = 'https://api.mangadex.org';
  String queryStr = '';
  RxBool loading = true.obs;
  @override
  void onInit() async {
    super.onInit();
    await getsearch();
    mangaId = await MangaApi().getId(mangars.value);
    coverImageRs = await MangaApi().getCoverArt(mangaId.coverId);
    authorNameRs = await MangaApi().getAuthor(mangaId.authorId);

    // print(coverImageRs);
    loading(false);
  }

  Future<void> getsearch() async {
    if (searchFilter.title.value == '') {
      // print(searchFilter.genresId);
      searchFilter.genresId.isEmpty
          ? null
          : searchFilter.genresId.map((element) {
              queryStr += '&includedTags%5B%5D=$element';
            }).toString();
      searchFilter.lang == null
          ? null
          : queryStr += '&originalLanguage%5B%5D=${searchFilter.lang}';
      searchFilter.status == null
          ? null
          : queryStr += '&status%5B%5D=${searchFilter.status}';
      searchFilter.year == null
          ? null
          : queryStr += '&year=${searchFilter.year}';
    } else {
      queryStr +=
          '&title=${searchFilter.title.toString().split(' ').join('+')}';
    }
    // print(queryStr);
    var respone = await dio.get('$api/manga?limit=10$queryStr');
    mangars = Manga(
            result: Manga.fromJson(respone.data).result,
            response: Manga.fromJson(respone.data).response,
            data: Manga.fromJson(respone.data).data,
            limit: Manga.fromJson(respone.data).limit,
            offset: Manga.fromJson(respone.data).offset,
            total: Manga.fromJson(respone.data).total)
        .obs;
  }

  Future<void> clearSearchData() async {
    mangars = Manga().obs;
    queryStr = '';
    searchFilter.year = null;
    searchFilter.status == null;
    searchFilter.title = ''.obs;
    searchFilter.genres.clear();
    searchFilter.genresId.clear();
  }
}
