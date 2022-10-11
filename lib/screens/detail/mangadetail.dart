import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangak/api/manga.dart';
import 'package:mangak/screens/components/appbar.dart';
import 'package:mangak/screens/components/infoappbar.dart';
import 'package:mangak/screens/components/mangacolumn.dart';
import 'package:mangak/screens/detail/mangadetailcontroller.dart';
import 'package:mangak/theme/constain.dart';

class MangaDetail extends GetView<DetailController> {
  const MangaDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailController detailController = Get.put(DetailController());
    DataManga manga = Get.arguments['manga'];
    double height = Get.height;
    double width = Get.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar2(
          onBack: () => Get.back(),
          title: 'Manga',
          height: context.orientation == Orientation.portrait
              ? width * 0.15
              : height * 0.15,
          more: [
            PopupMenuButton(
              icon: const Icon(Icons.more_horiz,
                  color: kPrimaryBlackColor, size: 25),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.notifications_active_outlined,
                        size: 25,
                        color: kPrimaryBlackColor,
                      ),
                      SizedBox(width: 10),
                      Text('Notification'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () => detailController.fireStore
                      .addFavorite(detailController.mangaId.toString()),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite_outline,
                        size: 25,
                        color: kPrimaryBlackColor,
                      ),
                      SizedBox(width: 10),
                      Text('Like'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.share,
                        size: 25,
                        color: kPrimaryBlackColor,
                      ),
                      SizedBox(width: 10),
                      Text('Share'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: context.orientation == Orientation.portrait
                    ? width * 0.4
                    : height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(controller.mangaCover.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.7,
                          child: Text(manga.attributes!.title!.en.toString(),
                              // maxLines: 2,
                              style: const TextStyle(
                                fontSize: 18,
                                color: kPrimaryBlackColor,
                              )),
                        ),
                        const Spacer(),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(detailController.user.uid)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return IconButton(
                                  onPressed: () => {
                                    if (snapshot.data!['favorites']
                                        .contains(controller.mangaId.value))
                                      {
                                        controller.fireStore.removeFavorite(
                                            controller.mangaId.toString())
                                      }
                                    else
                                      {
                                        controller.fireStore.addFavorite(
                                            controller.mangaId.toString())
                                      }
                                  },
                                  icon: snapshot.data!['favorites']
                                          .contains(controller.mangaId.value)
                                      ? const Icon(
                                          Icons.favorite_outlined,
                                          color: Colors.red,
                                          size: 25,
                                        )
                                      : const Icon(
                                          Icons.favorite_outline,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                );
                              }
                              return const CircularProgressIndicator();
                            }),
                        // Obx(() => IconButton(
                        //     onPressed: () => detailController.checkFavorite(),
                        //     icon: controller.favorites
                        //             .contains(controller.mangaId.value)
                        //         ? const Icon(
                        //             Icons.favorite_outlined,
                        //             size: 32,
                        //             color: Colors.red,
                        //           )
                        //         : const Icon(
                        //             Icons.favorite_outline,
                        //             size: 32,
                        //             color: Colors.black,
                        //           )))
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SizedBox(
                      height: height * 0.041,
                      width: width * 0.7,
                      child: AppBar(
                          backgroundColor: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          bottom: InfoAppBar(height: height, width: width)),
                    ),
                    SizedBox(
                      height: height * 0.57,
                      child: TabBarView(
                        children: [
                          MangaColumn(
                              height: height,
                              width: width,
                              author: detailController.mangaAuthor.value,
                              year: detailController.mangaYear.value,
                              description:
                                  detailController.mangaDescription.value),
                          // SizedBox(
                          //   height: height * 0.2,
                          //   child: const Center(child: Text('Chapter')),
                          // ),
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.5,
                                  child: Obx(
                                    (() => detailController.isLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: detailController
                                                .lsFeed.value.data!.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.toNamed('/feed',
                                                      arguments: {
                                                        'id': detailController
                                                            .lsFeed
                                                            .value
                                                            .data![index]
                                                      });
                                                },
                                                child: Container(
                                                    decoration: const BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color: Colors
                                                                    .grey))),
                                                    height: height * 0.1,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                            height:
                                                                height * 0.02),
                                                        Text(
                                                            'Chapter ${detailController.lsFeed.value.data![index].attributes!.chapter}'),
                                                        Text(
                                                          detailController
                                                                      .lsFeed
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .attributes!
                                                                      .title
                                                                      .toString() ==
                                                                  'null'
                                                              ? ''
                                                              : detailController
                                                                  .lsFeed
                                                                  .value
                                                                  .data![index]
                                                                  .attributes!
                                                                  .title
                                                                  .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                            'Language: ${detailController.lsFeed.value.data![index].attributes!.translatedLanguage}'),
                                                      ],
                                                    )),
                                              );
                                            },
                                          )),
                                  ),
                                ),
                                // Text('abc'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Container(
          height: 43,
          width: 280,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(colors: kSecondaryGradient)),
          child: InkWell(
            onTap: () {
              // print(detailController.lsFeed.value.data!);
              Get.toNamed('/feed',
                  arguments: {'id': detailController.lsFeed.value.data![0]});
            },
            child: const Center(
                child: Text(
              'Read First Chapter',
              style: TextStyle(color: kPrimaryWhiteColor, fontSize: 16),
            )),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
