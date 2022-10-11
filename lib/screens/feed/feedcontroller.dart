import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:mangak/api/feed.dart';
import 'package:mangak/api/imagefeed.dart';

class FeedController extends GetxController {
  Rx<DataFeed> chapter = DataFeed().obs;
  var dio = Dio();
  RxList mangaImg = [].obs;
  RxBool isLoading = true.obs;
  String api = 'https://api.mangadex.org';
  RxBool pinned = false.obs;
  @override
  void onInit() async {
    chapter.value = Get.arguments['id'];
    // print(chapterId.value);
    await getImage();
    super.onInit();
  }

  Future<void> getImage() async {
    try {
      var chapterapi = await dio.get(
        "$api/at-home/server/${chapter.value.id}",
      );
      var chapterImg = ImageFeed.fromJson(chapterapi.data);
      // print(chapterImg.chapter!.data);
      for (int i = 0; i < chapterImg.chapter!.data!.length; i++) {
        String url =
            '${chapterImg.baseUrl}/data/${chapterImg.chapter!.hash}/${chapterImg.chapter!.data![i]}';
        mangaImg.add(url);
      }
      // print('alo');
      // print(mangaImg);
      isLoading(false);
      // print(isLoading);
    } on DioError catch (ex) {
      Get.snackbar('Có lỗi khi lấy api', 'Quá thời gian chờ',
          snackPosition: SnackPosition.TOP);
      throw Exception(ex);
    }
  }

  Future<void> onRefresh() async {
    mangaImg.clear();
    isLoading(true);
    await getImage();
  }
}
