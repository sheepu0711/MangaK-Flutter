import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangak/ulti/data.dart';
import 'package:mangak/ulti/manga_api.dart';
import 'routes/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<MangaApi>(() => MangaApi());
        Get.lazyPut<FireStoreData>(() => FireStoreData());
      }),
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Ubuntu'),
    );
  }
}
