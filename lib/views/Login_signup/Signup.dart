import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/RegisterController.dart';

import 'SignInButton.dart';
import 'SignupForm.dart';
import 'ToggelButtonsRow.dart';

class SignUp extends StatelessWidget {
  final RegisterController controller = Get.find();

  SignUp({super.key});

  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff388175),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff388175), Color(0xff388175)]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                'Create Your Account',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Form(
                    key: signupFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 25,
                        ),
                        ToggleButtonsRow(
                          selectedIndex: controller
                              .selectedIndex, // Pass the RxInt directly
                          // Pass the method directly
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SignupForm(controller: controller),
                        const SizedBox(
                          height: 40,
                        ),
                        // SignUpButton InputFields and widgets follow similar structure
                        Obx(() => controller.isLoadingForSignup.value
                            ? Center(child: CircularProgressIndicator())
                            : SignUpButton(
                                onPressed: () {
                                  if (signupFormKey.currentState!.validate()) {
                                    controller.registerUser();
                                  }
                                },
                              )),
                        const SizedBox(
                          height: 150,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
