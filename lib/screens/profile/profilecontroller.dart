import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mangak/ulti/data.dart';
import 'package:mangak/api/manga.dart';
import 'package:mangak/ulti/manga_api.dart';
import 'package:mangak/api/mangaid.dart';
import 'package:image_picker/image_picker.dart';

var dio = Dio();

class ProfileController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  final user = FirebaseAuth.instance.currentUser;
  String path = '';
  File? file;
  UploadTask? upload;
  final fireStore = Get.find<FireStoreData>();
  final ImagePicker _picker = ImagePicker();
  late final XFile? image;
  var username = Get.arguments['username'];
  var name = Get.arguments['name'];
  var avatar = Get.arguments['avatar'];
  RxList favorites = [].obs;
  List<String> coverImageRs = <String>[];
  List<String> authorNameRs = <String>[];
  Manga manga = Manga();
  MangaId mangaId = MangaId();
  RxBool loading = true.obs;
  RxBool isEmpty = true.obs;
  @override
  void onInit() async {
    super.onInit();
    await getManga();
    loading(false);
  }

  Future<void> takeImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source);
      if (image == null) {
        return;
      }
      path = 'avatar/${user!.uid}.png';
      upload = storageRef.child(path).putFile(File(image.path));
      final snapshot = await upload!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      await fireStore.updateAvatar(urlDownload);
      upload = null;
    } on PlatformException catch (e) {
      //print(e);
      Get.snackbar('Error', e.message!);
    } on FirebaseException catch (e) {
      //print(e);
      Get.snackbar('Error', e.message.toString());
    }
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: upload?.snapshotEvents,
        builder: (context, snapshot) {
          //print('change');
          //print(upload?.snapshotEvents);
          if (snapshot.hasData) {
            final snap = snapshot.data as TaskSnapshot;
            double progress = snap.bytesTransferred / snap.totalBytes;
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(value: progress),
                  Center(
                    child: Text('${(100 * progress).roundToDouble()}%'),
                  )
                ],
              ),
            );
          }
          return const SizedBox();
        },
      );

  Future getManga() async {
    var test = await fireStore.getDataBase();
    favorites.value = test['favorites'];
    String query = '';
    favorites.map((element) {
      query += '&ids%5B%5D=$element';
    }).toString();
    if (favorites.isNotEmpty) {
      isEmpty(false);
      var mangaApi = await dio.get(
        "https://api.mangadex.org/manga/?${query.substring(1)}",
      );
      manga = Manga.fromJson(mangaApi.data);
      mangaId = await MangaApi().getId(manga);
      coverImageRs = await MangaApi().getCoverArt(mangaId.coverId);
      authorNameRs = await MangaApi().getAuthor(mangaId.authorId);
    }
  }
}
