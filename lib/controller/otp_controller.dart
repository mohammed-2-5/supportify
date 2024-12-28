// import 'package:email_otp/email_otp.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:on_bording/controller/RegisterController.dart';
//
// import '../views/Login_signup/login_screen.dart';
//
// class OtpController extends GetxController {
//
//
//   final FirebaseFirestore fireStore = FirebaseFirestore.instance;
//   EmailOTP myAuth = EmailOTP();
//
//   var otpField = ''.obs;
//   var userDoc = Rx<DocumentReference?>(null);
//   var isLoading = false.obs;
//   Future<void> checkEmailInUsersCollection(String email) async {
//     isLoading.value = true;
//     try {
//       QuerySnapshot snapshot = await fireStore.collection('users').where('email', isEqualTo: email).get();
//       if (snapshot.docs.isNotEmpty) {
//         userDoc.value = snapshot.docs.first.reference;
//       } else {
//         userDoc.value = null;
//       }
//     } catch (e) {
//       userDoc.value = null;
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> sendOtp(String email) async {
//     myAuth.setConfig(
//       appEmail: "me@rohitchouhan.com",
//       appName: "Supportify",
//       userEmail: email,
//       otpLength: 5,
//       otpType: OTPType.digitsOnly,
//     );
//     if (await myAuth.sendOTP() == true) {
//       Get.snackbar('Success', 'The otp was sent');
//     } else {
//       Get.snackbar('Error', 'Oops, OTP send failed');
//     }
//   }
//
//   Future<void> verifyOtp(String email) async {
//     if (await myAuth.verifyOTP(otp: otpField.value) == true) {
//       await checkEmailInUsersCollection(email);
//       if (userDoc.value != null) {
//         await userDoc.value!.update({'isVerified': true});
//         DocumentSnapshot<Object?> userSnapshot = await userDoc.value!.get();
//         bool isVerified = userSnapshot['isVerified'] ?? false;
//         if (isVerified) {
//           Get.snackbar('Verify', 'OTP is verified');
//           Get.offAll(() => LoginScreen());
//         }
//       } else {
//         Get.snackbar('Error', 'User document not found.');
//       }
//     } else {
//       Get.snackbar('Error', 'Error');
//       if (userDoc.value != null) {
//         await userDoc.value!.update({'isVerified': false});
//       }
//     }
//   }
// }
