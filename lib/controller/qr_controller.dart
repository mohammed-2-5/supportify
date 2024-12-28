import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../views/Settings/done_rate.dart';

class QRController extends GetxController {
  var lastScannedCode = ''.obs;
  var isCodeDetected = false.obs;

  var points = 0.obs;
  final MobileScannerController cameraController = MobileScannerController();

  void onDetect(BarcodeCapture capture) async {
    final barcode = capture.barcodes.first;
    if (!isCodeDetected.value && barcode.rawValue != null) {
      lastScannedCode.value = barcode.rawValue!;
      isCodeDetected.value = true;
      cameraController.stop();
      print('${lastScannedCode.value}/////////////////');
      await handleQRCode(lastScannedCode.value);
    }
  }

  Future<void> handleQRCode(String scannedCode) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      var myAppliesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('MyApplies');

      var querySnapshot = await myAppliesCollection
          .where('PostId', isEqualTo: scannedCode)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Match found, update points and remove the post
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          var userDocRef =
              FirebaseFirestore.instance.collection('users').doc(userId);

          // Update totalPoints
          var userDoc = await transaction.get(userDocRef);
          if (userDoc.exists) {
            int currentPoints = userDoc.data()!['totalPoints'] ?? 0;
            transaction
                .update(userDocRef, {'totalPoints': currentPoints + 100});
          }

          // Remove the PostId from MyApplies
          for (var doc in querySnapshot.docs) {
            transaction.delete(doc.reference);
          }

          // Delete the document from the volunteers collection
          var volunteerDocRef = FirebaseFirestore.instance
              .collection('volunteers')
              .doc(scannedCode);
          transaction.delete(volunteerDocRef);
        });

        Get.snackbar(
          'Success',
          'Points added and PostId removed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          'Error',
          'No matching PostId found in MyApplies',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process QR code: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void navigateToDoneRateScreen() {
    if (lastScannedCode.value.isNotEmpty) {
      Get.offAll(() => const DoneRateScreen());
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
