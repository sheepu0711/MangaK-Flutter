import 'package:get/get.dart';

class SearchFilter {
  RxString title = ''.obs;
  RxString? lang;
  RxString? status;
  RxInt? year;
  RxList genres = [].obs;
  RxList genresId = [].obs;

  static final SearchFilter _singleton = SearchFilter._internal();

  factory SearchFilter() {
    return _singleton;
  }
  void clearAll() {
    lang!.value = 'en';
    title.value = '';
    status!.value = 'ongoing';
    year = null;
    genres.clear();
    genresId.clear();
  }

  SearchFilter._internal();
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["lang"] = lang;
    data["status"] = status;
    data["genres"] = genres;
    data["genresId"] = genresId;

    data["year"] = year;

    return data;
  }
}
