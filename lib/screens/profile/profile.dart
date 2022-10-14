import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mangak/screens/components/avatar.dart';
import 'package:mangak/screens/login/logincontroller.dart';
import 'package:mangak/screens/profile/profilecontroller.dart';
import 'package:mangak/theme/constain.dart';

import '../components/appbar.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      appBar: CustomAppBar2(
        height: context.orientation == Orientation.portrait
            ? width * 0.15
            : height * 0.15,
        onBack: () {
          Get.back();
        },
        title: 'My Profile',
        more: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  height: height * 0.3,
                  width: width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.change_circle),
                          title: const Text('Change password'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.edit),
                          title: const Text('Update user info'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.remove_circle),
                          title: const Text('Unfollow'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: kPrimaryBlackColor,
                          ),
                          title: const Text(
                            'Log out',
                            style: TextStyle(color: kPrimaryBlackColor),
                          ),
                          onTap: () async {
                            await Get.put<LoginController>(LoginController())
                                .logout();
                            Get.offAllNamed('/login');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.more_horiz,
              size: 25,
              color: kPrimaryBlackColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 33, right: 22, top: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.userChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Avatar(
                        avatar: snapshot.data!.photoURL.toString(),
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              height: height * 0.23,
                              width: width,
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('Take a photo'),
                                      onTap: () async => controller
                                          .takeImage(ImageSource.camera),
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo),
                                      title: const Text('Choose from gallery'),
                                      onTap: () async => controller
                                          .takeImage(ImageSource.gallery),
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.remove_circle),
                                      title: const Text('Show default avatar'),
                                      onTap: () {
                                        Get.dialog(
                                          AlertDialog(
                                            content: Image.network(
                                              FirebaseAuth.instance.currentUser!
                                                  .photoURL
                                                  .toString(),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    controller.buildProgress(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Image.asset('assets/images/mangak.png');
                  }),
              title: Text(
                controller.username.toString(),
                style: const TextStyle(fontSize: 24, color: kPrimaryBlackColor),
              ),
              subtitle: Text(controller.name.toString(),
                  style: const TextStyle(
                      fontSize: 16, color: kSecondaryGrayColor)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              height: height * 0.02,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1))),
            ),
            SizedBox(
              height: context.orientation == Orientation.portrait
                  ? height * 0.1
                  : height * 0.2,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('425',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 24, color: kPrimaryBlackColor)),
                        Text('Visited',
                            style: TextStyle(
                                fontSize: 16, color: kSecondaryGrayColor)),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    color: kSecondaryGrayColor,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    width: width * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Text(controller.favorites.length.toString(),
                            style: const TextStyle(
                                fontSize: 24, color: kPrimaryBlackColor))),
                        const Text('Likes',
                            style: TextStyle(
                                fontSize: 16, color: kSecondaryGrayColor)),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    color: kSecondaryGrayColor,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    width: width * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('14',
                            style: TextStyle(
                                fontSize: 24, color: kPrimaryBlackColor)),
                        Text('Follows',
                            style: TextStyle(
                                fontSize: 16, color: kSecondaryGrayColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Text(
              'Loved',
              style: TextStyle(fontSize: 16, color: kPrimaryBlackColor),
            ),
            Expanded(
              child: Obx(() => controller.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.isEmpty.value
                      ? const Center(
                          child: Text(
                            'You don\'t have any loved manga',
                            style: TextStyle(
                                color: kPrimaryBlackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : GridView.builder(
                          itemCount: controller.favorites.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (context, index) => InkWell(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Image.network(
                                        controller.coverImageRs[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            width: double.infinity,
                                            color: Colors.white,
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 8.0, 8.0, 8.0),
                                            child: Text(
                                              controller.mangaId.title[index],
                                              maxLines: 5,
                                              textAlign: TextAlign.center,
                                            )),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }
}
