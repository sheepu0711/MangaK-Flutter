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
    if (user == null) {
      await Future.delayed(const Duration(seconds: 3));
      Get.offNamed('/login');
    } else {
      await Future.delayed(const Duration(seconds: 3));
      // print(user);
      Get.offNamed('/home');
    }
  }
}
