import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mangak/screens/components/custombutton.dart';
import 'package:mangak/screens/genres/genrescontroller.dart';
import 'package:mangak/theme/constain.dart';

class Genres extends GetView<GenresController> {
  const Genres({super.key});

  @override
  Widget build(BuildContext context) {
    final GenresController controller = Get.put(GenresController());
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              children: [
                const Text(
                  'Let Us Know!',
                  style: TextStyle(fontSize: 36),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  width: width * 0.5,
                  child: const Center(
                    child: Text(
                      'Choose your genre to find favorite titles here!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, color: kSecondaryGrayColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                SizedBox(
                  height: height * 0.65,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: height * 0.13,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 30.0,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        controller.checkTag(
                            controller.genres.entries.toList()[index].key);
                        // print(controller.selectedGenres);
                      },
                      child: Obx(
                        () => Container(
                          decoration: BoxDecoration(
                              color: controller.selectedGenres.contains(
                                      controller.genres.entries
                                          .toList()[index]
                                          .key)
                                  ? null
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              gradient: controller.selectedGenres.contains(
                                      controller.genres.entries
                                          .toList()[index]
                                          .key)
                                  ? const LinearGradient(
                                      colors: kSecondaryGradient)
                                  : null),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                    height: height * 0.1,
                                    width: width * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Lottie.asset(
                                        controller.genres.entries
                                            .toList()[index]
                                            .value,
                                        animate: true,
                                        fit: BoxFit.scaleDown)),
                              ),
                              Text(
                                  controller.genres.entries.toList()[index].key)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomButton(
                  width: width,
                  height: height,
                  textlabel: 'Continues',
                  onTap: controller.continues,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                InkWell(
                    onTap: () => Get.offAllNamed('/home'),
                    child: const Text('Skip for now!')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
