import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/Login_signup/login_screen.dart';
import '../views/MainScreen/main_screen.dart';
import 'HomeController.dart';

class LoginController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final isLoggedIn = false.obs;
  SharedPreferences? _prefs;

  final email = TextEditingController();
  final password = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  var isLoadingForLogin = false.obs;
  var emailExists = false.obs;
  var userDoc = Rx<DocumentReference?>(null);

  @override
  void onInit() async {
    super.onInit();
    loadLoginState();
  }

  void loadLoginState() async {
    _prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = _prefs?.getBool('isLoggedIn') ?? false;
  }

  Future<void> checkEmailInUsersCollection(String email) async {
    try {
      QuerySnapshot snapshot = await fireStore.collection('users').where('email', isEqualTo: email).get();
      if (snapshot.docs.isNotEmpty) {
        userDoc.value = snapshot.docs.first.reference;
        emailExists.value = true;
      } else {
        userDoc.value = null;
        emailExists.value = false;
      }
    } catch (e) {
      userDoc.value = null;
      emailExists.value = false;
    }
  }

  void login() async {
    isLoadingForLogin.value = true;
    try {
      await checkEmailInUsersCollection(email.text.trim());
      if (userDoc.value == null) {
        throw Exception("User not found");
      }
      DocumentSnapshot<Object?> userSnapshot = await userDoc.value!.get();
      bool isVerified = userSnapshot['isVerified'] ?? false;
      if (isVerified) {
        UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
        isLoggedIn.value = true;
        _prefs?.setBool('isLoggedIn', true);
        HomeController homeController = Get.find();
        homeController.updateData();
        Get.offAll(() => const MainScreen());
      } else {
        Get.snackbar('Error', 'Please verify your email address before logging in.');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString());
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    } finally {
      isLoadingForLogin.value = false;
    }
  }

  Future<void> resetPassword({required String email, required BuildContext context}) async {
    await checkEmailInUsersCollection(email);
    if (!emailExists.value) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Please write a valid email',
      ).show();
      return;
    }
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Success',
        desc: 'Check your email for reset password and back to login again',
        btnOkOnPress: () {
          Get.offAll(LoginScreen());
        },
      ).show();
    } on FirebaseAuthException catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: e.code,
      ).show();
    }
  }

  void logout() async {
    isLoggedIn.value = false;
    _prefs?.setBool('isLoggedIn', false);
    await firebaseAuth.signOut();
    Get.offAll(LoginScreen());
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
