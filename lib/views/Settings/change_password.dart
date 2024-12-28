import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/core/Components/functions.dart';
import 'package:on_bording/core/Widgets/InputField.dart';

import '../../controller/change_password_controller.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final PasswordController controller = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Change Password',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10.0),
              InputField(
                  label: 'Old Password',
                  icon: Icons.lock_outline,
                  hintLabel: 'Password',
                  isPasswordField: true,
                  controller: controller.oldpassword,
                  validator: passwordValidator),
              const SizedBox(height: 10.0),
              InputField(
                label: 'New Password',
                icon: Icons.lock_outline,
                hintLabel: 'New Password',
                isPasswordField: true,
                controller: controller.newpassword,
                validator: passwordValidator,
              ),
              const SizedBox(height: 10.0),
              InputField(
                label: 'Confirm New Password',
                icon: Icons.lock_outline,
                hintLabel: 'Confirm New Password',
                isPasswordField: true,
                controller: controller.confirmpassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != controller.newpassword.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onChanged: (_) {
                  // Triggers form revalidation whenever the user types or edits the text
                  controller.formKey.currentState?.validate();
                },
              ),
              const SizedBox(height: 25.0),
              ElevatedButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.changePassword(context);
                  }
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 15)),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(
                      double.maxFinite,
                      48)), // Adjusts button size within the container
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(
                      0xff388175)), // Makes the button itself transparent
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
