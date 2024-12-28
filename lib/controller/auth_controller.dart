// import 'dart:io';
//
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:email_otp/email_otp.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../views/Login_signup/login_screen.dart';
// import '../views/Settings/check_otp.dart';
// import '../views/MainScreen/main_screen.dart';
// import 'HomeController.dart';
//
// class AuthController extends GetxController {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   final isLoggedIn = false.obs;
//   SharedPreferences? _prefs;
//
//   @override
//   void onInit() async {
//     super.onInit();
//     loadLoginState();
//   }
//
//   void loadLoginState() async {
//     _prefs = await SharedPreferences.getInstance();
//     isLoggedIn.value = _prefs?.getBool('isLoggedIn') ?? false;
//   }
//   final FirebaseFirestore fireStore = FirebaseFirestore.instance;
//   EmailOTP myAuth = EmailOTP();
//
//   var isLoadingForLogin = false.obs; // Observable to track loading state
//   var isLoadingForSignup = false.obs; // Observable to track loading state
//
//   final email = TextEditingController();
//   final password = TextEditingController();
//   final fullname = TextEditingController();
//   final location = TextEditingController();
//   final type = TextEditingController();
//   final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
//   var isLoading = false.obs;
//   var emailExists = false.obs;
//   var userDoc = Rx<DocumentReference?>(null);
//   var otpField=''.obs;
//   var confirmOtpFiled=''.obs;
//
//
//
//   Future<void> checkEmailInUsersCollection(String email) async {
//     isLoading.value = true;
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .where('email', isEqualTo: email)
//           .get();
//       if (snapshot.docs.isNotEmpty) {
//         userDoc.value = snapshot.docs.first.reference;
//         emailExists.value = true;
//       } else {
//         userDoc.value = null;
//         emailExists.value = false;
//       }
//     } catch (e) {
//       print('Error checking email in users collection: $e');
//       userDoc.value = null;
//       emailExists.value = false;
//     }finally {
//       isLoading.value = false;
//     }
//   }
//   Future verifyOtp(String email)async{
//     if (await myAuth.verifyOTP(otp: otpField.value) == true) {
//       checkEmailInUsersCollection(email);
//       await userDoc.value?.update({'isVerified':true});
//       Get.snackbar('Verify', 'OTP is verified');
//       Get.offAll(()=>LoginScreen());
//     }
//     else {
//
//       await userDoc.value?.update({'isVerified':false});
//       Get.snackbar('Error ', 'Error');
//     }
//   }
//   Future sendOtp(String email)async {
//     myAuth.setConfig(
//         appEmail: "me@rohitchouhan.com",
//         appName: "Supportify",
//         userEmail: email,
//         otpLength: 5,
//         otpType: OTPType.digitsOnly
//     );
//     if (await myAuth.sendOTP() == true) {
//
//       Get.snackbar('Success ', 'The otp was send');
//     } else {
//       Get.snackbar('Error', 'Oops, OTP send failed');
//     }
//   }
//   void registerUser() async {
//     try {
//       UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
//         email: email.text.trim(),
//         password: password.text.trim(),
//       );
//       String uid = userCredential.user!.uid;
//       await fireStore.collection('users').doc(uid).set({
//         'username': fullname.text.trim(),
//         'location': location.text.trim(),
//         'email': email.text.trim(),
//         'type': selectedType.toInt(),
//         'isVerified':false,
//         "imageUrl": url.value ?? "",
//       });
//       await sendOtp(email.text.trim());
//
//       Get.offAll(() =>  const CheckOtp());
//       isLoadingForSignup.value = false; // Stop loading after registration is complete
//     } on FirebaseAuthException catch (e) {
//       print("Firebase Auth Exception: ${e.code}, ${e.message}");
//       Get.snackbar('Error', e.message ?? 'Unknown Error', snackPosition: SnackPosition.BOTTOM);
//     } catch (e) {
//       print("General Exception: $e");
//       isLoadingForSignup.value = false; // Stop loading after registration is complete
//       Get.snackbar('Error', 'An unexpected error occurred', snackPosition: SnackPosition.BOTTOM);
//     }
//
//
//
//
//   }
//   var selectedIndex = 0.obs;
//   var selectedType = 1.obs;
//   void toggleSelection(int index , int type) {
//     selectedIndex.value = index;
//     selectedType.value= type ;
//
//   }
//
//   void login() async {
//     print(isLoggedIn);
//     isLoadingForLogin.value = true; // Start loading
//     try {
//       await checkEmailInUsersCollection(email.text.trim());
//       if (userDoc.value == null) {
//         throw Exception("User not found");
//       }
//       DocumentSnapshot<Object?> userSnapshot = await userDoc.value!.get();
//       bool isVerified = userSnapshot['isVerified'] ?? false;
//       print(isVerified);
//       if (isVerified) {
//         UserCredential userCredential =
//         await firebaseAuth.signInWithEmailAndPassword(
//           email: email.text.trim(),
//           password: password.text.trim(),
//         );
//         isLoggedIn.value = true;
//         _prefs?.setBool('isLoggedIn', true);
//         print(isLoggedIn);
//         HomeController homeController = Get.find();
//         homeController.updateData();
//         Get.snackbar('Success', 'Login success');
//         Get.offAll(() => const MainScreen());
//       } else {
//         Get.snackbar('Error', 'Please verify your email address before logging in.');
//       }
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar('Error', e.message.toString());
//     } catch (e) {
//       Get.snackbar('Error', 'An unexpected error occurred: $e');
//     } finally {
//       isLoadingForLogin.value = false; // Stop loading
//     }
//   }
//   void logout() async{
//     isLoggedIn.value = false;
//     _prefs?.setBool('isLoggedIn', false);
//
//     print('////////////////////');
//     print(isLoggedIn);
//     await FirebaseAuth.instance.signOut();
//     Get.offAll(LoginScreen());
//   }
//   @override
//   void onClose() {
//     // TODO: implement onClose
//     email.dispose();
//     password.dispose();
//     location.dispose();
//     fullname.dispose();
//     super.onClose();
//
//   }
//
//
//
//   Future<void> resetPassword({
//     required String email,
//     required BuildContext context
//   })async {
//     await checkEmailInUsersCollection(email);
//     if (!emailExists.value){
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.error,
//         animType: AnimType.rightSlide,
//         title: 'error',
//         desc: 'Please Write Valid email  ',
//       ).show();
//       return;
//     }
//     try{
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.success,
//         animType: AnimType.rightSlide,
//         title: 'Success',
//         desc: 'Check your email for reset password and back to login again',
//         btnOkOnPress: () {
//           Get.offAll(LoginScreen());
//         },
//       ).show();
//     }
//     on FirebaseAuthException catch(e){
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.error,
//         animType: AnimType.rightSlide,
//         title: 'error',
//         desc: e.code,
//         btnCancelOnPress: () {
//         },
//       ).show();
//     }
//   }
//
//
//
//
//   var url=''.obs;
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> pickImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//
//       if (pickedFile != null) {
//         File imageFile = File(pickedFile.path);
//         String? downloadUrl = await uploadImageToFirebase(imageFile);
//         url.value=downloadUrl!;
//
//         Get.snackbar('Success', 'Image uploaded successfully: $downloadUrl', snackPosition: SnackPosition.BOTTOM);
//             } else {
//         print('No image selected.');
//         Get.snackbar('No Image', 'No image was selected.', snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//       Get.snackbar('Error', 'Error picking image: $e', snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   // Method to upload image to Firebase Storage
//   Future<String?> uploadImageToFirebase(File imageFile) async {
//     String fileName = basename(imageFile.path);
//     var storageRef = FirebaseStorage.instance.ref().child('user_image/$fileName');
//
//     try {
//       var uploadTask = await storageRef.putFile(imageFile);
//       String downloadUrl = await uploadTask.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading image: $e');
//       Get.snackbar('Upload Failed', 'Failed to upload image: $e', snackPosition: SnackPosition.BOTTOM);
//       return null;
//     }
//   }
//
// }
