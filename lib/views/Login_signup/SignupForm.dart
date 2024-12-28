import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/RegisterController.dart';
import 'package:on_bording/core/Components/functions.dart';

import '../../core/Widgets/InputField.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.controller,
  });

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(
          controller: controller.fullname,
          hintLabel: 'Full Name',
          validator: (value) =>
              value!.isEmpty ? 'Please enter full name' : null,
          label: 'Full Name',
          icon: Icons.person,
        ),
        InputField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter an email address';
            } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                .hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
          controller: controller.email,
          hintLabel: 'Email Address',
          label: 'Email',
          icon: Icons.email_outlined,
        ),
        InputField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your location';
            }
            return null;
          },
          controller: controller.location,
          hintLabel: 'Location',
          label: 'Location',
          icon: Icons.location_pin,
        ),
        InputField(
          controller: controller.password,
          validator: passwordValidator,
          hintLabel: 'Password',
          label: 'Password',
          icon: Icons.lock_outline,
          isPasswordField: true,
        ),
        Obx(() {
          if (controller.selectedIndex.value == 0) {
            return InputField(
              controller: controller.taxRegistrationNumber,
              hintLabel: 'Tax Registration Number',
              validator: (value) => value!.isEmpty
                  ? 'Please enter your Tax Registration Number'
                  : null,
              label: 'Tax Registration Number',
              icon: Icons.receipt,
            );
          } else {
            return SizedBox.shrink();
          }
        }),
        SizedBox(
          height: 15,
        ),
        TextButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add Media'),
          onPressed: controller.pickImage,
        ),
      ],
    );
  }
}
