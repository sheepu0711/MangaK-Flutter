import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangak/screens/login/logincontroller.dart';
import 'package:mangak/theme/constain.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.06,
                ),
                const Center(
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                const Center(
                  child: Text(
                    'Login to continue',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                InkWell(
                  onTap: () async {
                    try {
                      await controller.signInWithGoogle();
                    } on FirebaseAuthException catch (e) {
                      Get.snackbar(
                        'Login Error',
                        e.message.toString(),
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 5),
                      );
                    }
                  },
                  child: Container(
                      width: width * 0.65,
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Image.asset(
                            'assets/images/google-logo.png',
                            width: 40,
                            height: 40,
                          ),
                          const Text(
                            'Continues with Google',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: width * 0.1,
                ),
                InkWell(
                  onTap: () async {
                    try {
                      await controller.signInWithFacebook();
                    } on FirebaseAuthException catch (e) {
                      Get.snackbar('Login Error', e.message.toString(),
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 5));
                    }
                  },
                  child: Container(
                      width: width * 0.65,
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2079FF),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Image.asset(
                            'assets/images/meta-logo.png',
                            width: 40,
                            height: 40,
                            color: Colors.white,
                          ),
                          const Text(
                            'Continues with Meta',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Obx(() => controller.signUp.value
                    ? Container()
                    : Text.rich(
                        TextSpan(
                          text: 'Haven\'t an account? ',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    controller.emailController.value.text = '';
                                    controller.passwordController.value.text =
                                        '';
                                    controller.signUp.value =
                                        !controller.signUp.value;
                                  },
                                text: 'Sign Up!',
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 16)),
                          ],
                        ),
                      )),
                SizedBox(
                  height: height * 0.05,
                ),
                Obx(
                  () => controller.signUp.value
                      ? Container(
                          height: height * 0.6,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45, vertical: 80),
                          decoration: const BoxDecoration(
                            gradient:
                                LinearGradient(colors: kSecondaryGradient),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.emailController.value,
                                decoration:
                                    const InputDecoration(hintText: 'Email'),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              Obx(() => TextFormField(
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        controller.isPasswordVisible.value =
                                            false;
                                      } else {
                                        controller.isPasswordVisible.value =
                                            true;
                                      }
                                    },
                                    controller:
                                        controller.passwordController.value,
                                    obscureText:
                                        controller.isPasswordVisible.value,
                                    decoration: InputDecoration(
                                      suffixIcon: controller.passwordController
                                              .value.text.isEmpty
                                          ? null
                                          : IconButton(
                                              icon:
                                                  const Icon(Icons.visibility),
                                              onPressed: controller
                                                  .togglePasswordVisibility,
                                            ),
                                      hintText: 'Password',
                                    ),
                                  )),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    controller.isPasswordVisible.value = false;
                                  } else {
                                    controller.isPasswordVisible.value = true;
                                  }
                                },
                                controller:
                                    controller.repasswordController.value,
                                obscureText: controller.isPasswordVisible.value,
                                decoration: const InputDecoration(
                                  hintText: 'Re-enter Password',
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: 'Have an account? ',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                  children: <TextSpan>[
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            controller.emailController.value
                                                .text = '';
                                            controller.passwordController.value
                                                .text = '';
                                            controller.repasswordController
                                                .value.text = '';
                                            controller.signUp.value =
                                                !controller.signUp.value;
                                          },
                                        text: 'Sign in!',
                                        style: const TextStyle(
                                            color: Colors.blue, fontSize: 16)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Obx(
                                () => InkWell(
                                  onTap:
                                      controller.createUserWithEmailAndPassword,
                                  child: Container(
                                    width: width * 0.65,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                      color:
                                          controller.checkRegisterField().value
                                              ? null
                                              : kSecondaryGrayColor,
                                      gradient:
                                          controller.checkRegisterField().value
                                              ? const LinearGradient(
                                                  colors: kSecondaryGradient)
                                              : null,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: kPrimaryWhiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: height * 0.6,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45, vertical: 80),
                          decoration: const BoxDecoration(
                            gradient:
                                LinearGradient(colors: kSecondaryGradient),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.emailController.value,
                                decoration:
                                    const InputDecoration(hintText: 'Email'),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    controller.isPasswordVisible.value = false;
                                  } else {
                                    controller.isPasswordVisible.value = true;
                                  }
                                },
                                controller: controller.passwordController.value,
                                obscureText: controller.isPasswordVisible.value,
                                decoration: InputDecoration(
                                  suffixIcon: controller
                                          .passwordController.value.text.isEmpty
                                      ? null
                                      : IconButton(
                                          icon: const Icon(Icons.visibility),
                                          onPressed: controller
                                              .togglePasswordVisibility,
                                        ),
                                  hintText: 'Password',
                                ),
                              ),
                              SizedBox(
                                height: height * 0.06,
                              ),
                              const Text(
                                'Forgot Password?',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Obx(
                                () => InkWell(
                                  onTap: controller.signInWithEmailAndPassword,
                                  child: Container(
                                    width: width * 0.65,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                      color: controller.checkLoginField().value
                                          ? null
                                          : kSecondaryGrayColor,
                                      gradient:
                                          controller.checkLoginField().value
                                              ? const LinearGradient(
                                                  colors: kSecondaryGradient)
                                              : null,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: kPrimaryWhiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
