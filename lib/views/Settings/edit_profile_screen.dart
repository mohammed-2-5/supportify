import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/core/Widgets/InputField.dart';
import 'package:on_bording/views/MainScreen/main_screen.dart';

import '../../controller/HomeController.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late HomeController controller;
  late TextEditingController fullname;
  late TextEditingController location;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomeController>(); // Initialize controller
    // Initialize TextEditingController instances with default values
    fullname = TextEditingController(text: controller.userModel.value.username);
    location = TextEditingController(text: controller.userModel.value.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title:
            const Text('Edit Profile', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: controller.userModel.value.imageUrl ?? '',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await controller.pickImage();
                },
                child: const Text('Change Profile Image'),
              ),
              const SizedBox(height: 20),
              InputField(
                label: 'Full Name',
                icon: Icons.person,
                hintLabel: 'Full Name',
                controller: fullname,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter full name' : null,
                onChanged: (_) =>
                    formKey.currentState!.validate(), // Trigger validation
              ),
              const SizedBox(height: 10.0),
              InputField(
                label: 'Location',
                icon: Icons.location_pin,
                hintLabel: 'Location',
                controller: location,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your location' : null,
                onChanged: (_) => formKey.currentState!.validate(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF388175),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await controller.updateUserData(
                        fullname.text, location.text);
                    Get.offAll(() => const MainScreen());
                  }
                },
                child: const Text('Save',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
