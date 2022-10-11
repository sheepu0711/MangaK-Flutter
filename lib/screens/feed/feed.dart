import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangak/screens/components/appbar.dart';
import 'package:mangak/theme/constain.dart';
import 'feedcontroller.dart';
import 'package:gallery_saver/gallery_saver.dart';

class Feed extends GetView<FeedController> {
  const Feed({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FeedController feedController = Get.put(FeedController());
    double height = Get.height;

    double width = Get.width;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: feedController.onRefresh,
        child: CustomScrollView(
          physics: const RangeMaintainingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              snap: true,
              floating: true,
              elevation: 0,
              toolbarHeight: context.orientation == Orientation.portrait
                  ? width * 0.15
                  : height * 0.15,
              flexibleSpace: CustomAppBar(
                height: width * 0.15,
                onBack: () {
                  Get.back();
                },
                title:
                    'Chapter ${feedController.chapter.value.attributes!.chapter}: ${feedController.chapter.value.attributes!.title ?? 'No Title'}',
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
            ),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onLongPress: () => Get.defaultDialog(
                        title: 'Save Image',
                        content: const Text('Do you want to save this image?'),
                        onConfirm: () async {
                          Get.back();
                          await GallerySaver.saveImage(
                              feedController.mangaImg[index],
                              toDcim: true);
                          Get.snackbar('Success', 'Image saved',
                              snackPosition: SnackPosition.BOTTOM);
                        },
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        imageUrl: feedController.mangaImg[index],
                        placeholder: (context, url) => Center(
                            child: Container(
                          height: 500,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: const Center(
                            child: Text(
                              'Loading',
                              style: TextStyle(
                                fontSize: 18,
                                color: kPrimaryBlackColor,
                              ),
                            ),
                          ),
                        )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    );
                  },
                  childCount: feedController.mangaImg.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
