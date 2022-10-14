import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    await initState();
  }

  Future<void> initState() async {
    var user = FirebaseAuth.instance.currentUser;
    await Future.delayed(const Duration(seconds: 3));
    if (user == null) {
      Get.offNamed('/login');
    } else {
      Get.offNamed('/home');
    }
  }
}
