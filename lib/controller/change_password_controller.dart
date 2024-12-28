import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/Settings/settings_screen.dart';

class PasswordController extends GetxController {
  final TextEditingController oldpassword = TextEditingController();
  final TextEditingController newpassword = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> changePassword(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final cred = EmailAuthProvider.credential(
          email: user.email!,
          password: oldpassword.text,
        );

        await user.reauthenticateWithCredential(cred);

        await user.updatePassword(newpassword.text);

        Get.snackbar(
          'Success ',
          'Password changed successfully',
          snackPosition: SnackPosition.BOTTOM,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        );
      } catch (e) {
        // عرض رسالة خطأ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to change password: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers when the controller is removed
    oldpassword.dispose();
    newpassword.dispose();
    confirmpassword.dispose();
    super.dispose();
  }
}
