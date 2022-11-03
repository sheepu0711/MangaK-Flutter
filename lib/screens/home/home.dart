import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangak/screens/home/labeltitle.dart';
import 'package:mangak/ulti/manga_api.dart';
import 'package:mangak/screens/components/loadingshrimmer.dart';
import 'package:mangak/screens/home/homecontroller.dart';
import 'package:mangak/screens/home/searchdialog.dart';

import '../../theme/constain.dart';
import '../components/custom_text_fields.dart';
import '../components/list_tile.dart';
import '../components/mangacard.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: RefreshIndicator(
          onRefresh: homeController.onRefresh,
          child: SingleChildScrollView(
            // physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 33,
                right: 22,
                top: 14,
              ),
              child: Column(
                children: [
                  Tile(
                    onTap: () {
                      MangaApi().toProfile(
                          username: homeController.user!.displayName.toString(),
                          name: 'MangaK - User',
                          avatar: homeController.user!.photoURL.toString());
                    },
                    onReload: () {
                      controller.onRefresh();
                    },
                    avatar: homeController.user!.photoURL.toString(),
                    username: homeController.user!.displayName.toString(),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    onSubmitted: (value) {
                      homeController.searchFilter.value.title.value = value;
                      MangaApi().toSearch(
                          searchFilter: homeController.searchFilter.value);
                    },
                    height: context.orientation == Orientation.portrait
                        ? width * 0.1
                        : height * 0.1,
                    onEnd: () {
                      homeController.onFilter();
                      Get.dialog(
                        WillPopScope(
                          onWillPop: () {
                            homeController.clearTag();
                            Get.back();
                            return Future.value(true);
                          },
                          child: SearchAlertDialog(
                              height: height,
                              width: width,
                              homeController: homeController),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const LabelTitle(
                    title: 'Treding Manga',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: context.orientation == Orientation.portrait
                        ? height * 0.35
                        : width * 0.18,
                    child: Obx(
                      () => homeController.isLoading.value
                          ? LoadingShrimmerCard(height: height, width: width)
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: homeController.mangaId.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  MangaCard(
                                onTap: () {
                                  MangaApi().toDetail(
                                      author: homeController.authorName[index],
                                      cover: homeController.coverImage[index],
                                      manga:
                                          homeController.lsmanga.data![index]);
                                },
                                title: homeController.title[index].toString(),
                                author: homeController.authorName[index],
                                cover: homeController.coverImage[index],
                                id: homeController.mangaId[index],
                                height: height,
                                width: width,
                              ),
                            ),
                    ),
                  ),
                  const LabelTitle(
                    title: 'Top Readers',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => homeController.isLoading.value
                        ? TopReaderShrimmer(height: height)
                        : SizedBox(
                            height: context.orientation == Orientation.portrait
                                ? height * 0.1
                                : height * 0.2,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: homeController
                                  .randomUser.value.results!.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  MangaApi().toProfile(
                                      username: homeController.randomUser.value
                                          .results![index].login!.username!,
                                      name:
                                          '${homeController.randomUser.value.results![index].name!.first!} ${homeController.randomUser.value.results![index].name!.last}',
                                      avatar: homeController.randomUser.value
                                          .results![index].picture!.large!);
                                },
                                child: SizedBox(
                                  width: context.orientation ==
                                          Orientation.portrait
                                      ? width * 0.2
                                      : height * 0.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.blue,
                                          backgroundImage: Image.network(
                                                  homeController
                                                      .randomUser
                                                      .value
                                                      .results![index]
                                                      .picture!
                                                      .large!)
                                              .image),
                                      Text(
                                        homeController.randomUser.value
                                            .results![index].login!.username!,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: kPrimaryBlackColor),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Container(
                                width: 10,
                              ),
                            )),
                  ),
                  Obx(
                    () => homeController.isLast.value
                        ? Container()
                        : Column(
                            children: const [
                              LabelTitle(title: 'Continues Reading'),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(homeController.user!.uid)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return ContinuesReading(height: height, width: width);
                      } else if (snapshot.hasData &&
                          snapshot.data!['lastRead'] != '') {
                        //print(snapshot.data!['lastRead']);
                        homeController.getLast(snapshot.data!['lastRead']);
                        return InkWell(
                          onTap: () => MangaApi().toDetail(
                              manga: homeController.lastManga.value,
                              cover: homeController.lastCoverArt.value,
                              author: 'author'),
                          child: Container(
                            height: context.orientation == Orientation.portrait
                                ? height * 0.1
                                : height * 0.2,
                            width: width * 0.9,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              gradient: const LinearGradient(
                                  colors: kSecondaryGradient,
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft),
                            ),
                            child: Row(children: [
                              SizedBox(
                                height:
                                    context.orientation == Orientation.portrait
                                        ? height * 0.08
                                        : height * 0.15,
                                width:
                                    context.orientation == Orientation.portrait
                                        ? height * 0.08
                                        : height * 0.15,
                                child: Obx(() => ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.network(
                                        homeController.lastCoverArt.value,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 70,
                                child: Obx(() => Center(
                                      child: SizedBox(
                                        width: width * 0.5,
                                        child: Text(
                                          homeController.lastTitle.value
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )),
                              ),
                              const Spacer(),
                              const Icon(Icons.play_arrow)
                            ]),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
