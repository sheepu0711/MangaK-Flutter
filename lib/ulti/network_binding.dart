import 'package:get/get.dart';
import 'package:mangak/ulti/data.dart';
import 'package:mangak/ulti/manga_api.dart';

class NetworkBinding extends Bindings {
  // dependence injection attach our class.
  @override
  void dependencies() {
    Get.lazyPut<MangaApi>(() => MangaApi());
    Get.lazyPut<FireStoreData>(() => FireStoreData());
  }
}
