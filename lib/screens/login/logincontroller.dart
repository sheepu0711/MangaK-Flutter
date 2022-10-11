import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> repasswordController = TextEditingController().obs;
  RxBool isPasswordVisible = false.obs;
  RxBool signUp = false.obs;

  Future checkIfUserLoginBefore() async {
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    if (user.displayName == null || user.photoURL == null) {
      await user.updateDisplayName('MangaK');
      await user.updatePhotoURL('https://i.imgur.com/WvSdY7M.png');
    }

    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(user.uid.toString()).get();
    if (!documentSnapshot.exists) {
      await firestore.collection('users').doc(user.uid.toString()).set({
        'favorites': [],
        'genres': [],
        'lastRead': '',
        'description': '',
      });
      return await Get.offAllNamed('/genres');
    } else {
      return await Get.offAllNamed('/home');
    }
  }

  Future createUserWithEmailAndPassword() async {
    if (passwordController.value.text == repasswordController.value.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.value.text,
            password: passwordController.value.text);
        checkIfUserLoginBefore();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar('Error', 'The password provided is too weak.',
              snackPosition: SnackPosition.BOTTOM);
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('Error', 'The account already exists for that email.',
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar('Error', e.message.toString(),
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    } else {
      Get.snackbar('Error', 'Password does not match.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text);
      checkIfUserLoginBefore();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user.',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    checkIfUserLoginBefore();
  }

  Future signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    checkIfUserLoginBefore();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Rx<bool> checkLoginField() {
    if (emailController.value.text.isEmpty ||
        passwordController.value.text.isEmpty) {
      return false.obs;
    }
    return true.obs;
  }

  Rx<bool> checkRegisterField() {
    if (emailController.value.text.isEmpty ||
        passwordController.value.text.isEmpty ||
        repasswordController.value.text.isEmpty ||
        passwordController.value.text != repasswordController.value.text) {
      return false.obs;
    }
    return true.obs;
  }

  Future logout() async {
    // await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
