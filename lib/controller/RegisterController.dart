import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../views/Login_signup/login_screen.dart';
import '../views/Settings/check_otp.dart';

class RegisterController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final location = TextEditingController();
  final taxRegistrationNumber = TextEditingController();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  EmailOTP myAuth = EmailOTP();

  var otpField = ''.obs;
  var userDoc = Rx<DocumentReference?>(null);
  var isLoading = false.obs;

  var isLoadingForSignup = false.obs; // Observable to track loading state

  var url = ''.obs;
  final ImagePicker _picker = ImagePicker();

  var selectedIndex = 0.obs;
  var selectedType = 1.obs;

  void toggleSelection(int index, int type) {
    selectedIndex.value = index;
    selectedType.value = type;
  }

  void registerUser() async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      String uid = userCredential.user!.uid;
      await fireStore.collection('users').doc(uid).set({
        'username': fullname.text.trim(),
        'location': location.text.trim(),
        'email': email.text.trim(),
        'type': selectedType.toInt(),
        'isVerified': false,
        'imageUrl': url.value ?? '',
        'totalPoints': 1000,
        'rate': 0,
        'feedback': '',
        'taxRegistrationNumber': selectedType.value == 0
            ? taxRegistrationNumber.text.trim()
            : '' // التحقق من الحقل
      });
      await sendOtp(email.text.trim());
      // await otpController.checkEmailInUsersCollection(email.text.trim());
      Get.offAll(() => const CheckOtp());
      isLoadingForSignup.value =
          false; // Stop loading after registration is complete
    } on FirebaseAuthException catch (e) {
      print(e.message! + '//////////');
      Get.snackbar('Error', e.message ?? 'Unknown Error',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e.toString() + '//////////');
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingForSignup.value =
          false; // Stop loading after registration is complete
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String? downloadUrl = await uploadImageToFirebase(imageFile);
        url.value = downloadUrl!;
        Get.snackbar('Success', 'Image uploaded successfully: $downloadUrl',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('No Image', 'No image was selected.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error picking image: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<String?> uploadImageToFirebase(File imageFile) async {
    String fileName = basename(imageFile.path);
    var storageRef =
        FirebaseStorage.instance.ref().child('user_image/$fileName');

    try {
      var uploadTask = await storageRef.putFile(imageFile);
      String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Get.snackbar('Upload Failed', 'Failed to upload image: $e',
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  //otp functions///////////
  Future<void> checkEmailInUsersCollection(String userEmail) async {
    isLoading.value = true;
    try {
      QuerySnapshot snapshot = await fireStore
          .collection('users')
          .where('email', isEqualTo: email.text.trim())
          .get();
      if (snapshot.docs.isNotEmpty) {
        userDoc.value = snapshot.docs.first.reference;
      } else {
        userDoc.value = null;
      }
    } catch (e) {
      userDoc.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOtp(String email) async {
    EmailOTP.config(
      appEmail: "me@rohitchouhan.com",
      appName: "Supportify",
      otpLength: 5,
      otpType: OTPType.alphaNumeric,
    );
    if (await EmailOTP.sendOTP(email: email) == true) {
      Get.snackbar('Success', 'The otp was sent');
    } else {
      Get.snackbar('Error', 'Oops, OTP send failed');
    }
  }

  Future<void> verifyOtp(String email) async {
    if (await EmailOTP.verifyOTP(otp: otpField.value) == true) {
      await checkEmailInUsersCollection(email);
      if (userDoc.value != null) {
        await userDoc.value!.update({'isVerified': true});
        DocumentSnapshot<Object?> userSnapshot = await userDoc.value!.get();
        bool isVerified = userSnapshot['isVerified'] ?? false;
        if (isVerified) {
          Get.snackbar('Verify', 'OTP is verified');
          Get.offAll(() => LoginScreen());
        }
      } else {
        Get.snackbar('Error', 'User document not found.');
      }
    } else {
      Get.snackbar('Error', 'Error');
      if (userDoc.value != null) {
        await userDoc.value!.update({'isVerified': false});
      }
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    fullname.dispose();
    location.dispose();
    super.onClose();
  }
}
