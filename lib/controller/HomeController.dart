import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../model/user_model.dart';

class HomeController extends GetxController {
  var userModel = UserModel(
    username: 'User',
    email: 'email@example.com',
    imageUrl: '',
    isVerified: false,
    location: '',
    rate: 0,
    totalPoints: 1000,
    type: 0,
  ).obs;

  var isLoading = false.obs;
  var numberOfButtons = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  void updateData() {
    getCurrentUser(); // This fetches the latest user data
  }

  void getCurrentUser() async {
    isLoading.value = true; // Start loading
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await fetchUserData(user.uid); // Ensure await is used here
    } else {
      userModel.update((val) {
        val?.username = 'Guest';
      });
      isLoading.value = false; // Stop loading here for non-logged users
    }
  }

  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        userModel.value = UserModel.fromMap(data);
        numberOfButtons.value = userModel.value.type == 0 ? 3 : 2;
        if (kDebugMode) {
          print(
              'Data fetched and updated for user: ${userModel.value.username}');
        }
      } else {
        if (kDebugMode) {
          print('No data exists for the user.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user data: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> applyForPost(String postId, String volunteerUserId) async {
    try {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      var myAppliesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('MyApplies');

      var querySnapshot =
          await myAppliesCollection.where('PostId', isEqualTo: postId).get();

      if (querySnapshot.docs.isEmpty) {
        await myAppliesCollection.add({'PostId': postId});
        Get.snackbar(
          'Success',
          'You have successfully applied for this post',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // Call the function to add the current user's name and email to the volunteer's document
        await addVolunteerToMyVolunteers(volunteerUserId, postId);

        return true;
      } else {
        Get.snackbar(
          'Already Applied',
          'You have already applied for this post',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        return false;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Failed to apply for the post: $error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return false;
    }
  }

  Future<void> addVolunteerToMyVolunteers(
      String volunteerUserId, String postId) async {
    try {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(volunteerUserId)
            .collection('MyVolunteers')
            .add({
          'name': userData['username'] ?? 'User',
          'email': userData['email'] ?? 'email@example.com',
          'imageUrl': userData['imageUrl'] ?? '',
          'volunteerId': currentUserId,
          'postId': postId
        });

        Get.snackbar(
          'Success',
          'Volunteer added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          'Error',
          'Current user data not found',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Failed to add volunteer: $error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  // var url = ''.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> updateUserData(String newUsername, String newLocation) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'username': newUsername,
          'location': newLocation,
        });
        userModel.update((val) {
          val?.username = newUsername;
          val?.location = newLocation;
        });
        print('User data updated successfully');
      } catch (e) {
        print('Failed to update user data: $e');
      }
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String? downloadUrl = await uploadImageToFirebase(imageFile);
        if (downloadUrl != null) {
          await updateUserImage(downloadUrl);
        }
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

  Future<void> updateUserImage(String imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'imageUrl': imageUrl,
        });
        userModel.update((val) {
          val?.imageUrl = imageUrl;
        });
        print('User image updated successfully');
      } catch (e) {
        print('Failed to update user image: $e');
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    updateData();
  }
}
