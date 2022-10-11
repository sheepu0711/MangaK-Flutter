import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_animations/im_animations.dart';
import 'package:mangak/screens/splash/splashcontroller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      body: Center(
        child: HeartBeat(
          child: SizedBox(
            height: height * 0.5,
            width: width * 0.5,
            child: Image.asset('assets/images/mangak.png'),
          ),
        ),
      ),
    );
  }
}
