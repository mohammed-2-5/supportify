import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/login_controller.dart';
import 'package:on_bording/views/Settings/find_your_account_screen.dart';
import 'LoginBackGround.dart';
import 'LoginButton.dart';
import 'LoginForm.dart';
import 'RememberMeCheckBox.dart';

import 'signup.dart';


class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.find();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoadingForLogin.isTrue
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          LoginBackGround(height: MediaQuery.of(context).size.height),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.loginFormKey,
                    child: Column(
                      children: <Widget>[
                        LoginForm(email: controller.email, password: controller.password),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Get.to(const FindYourAccountScreen(type: 0));
                          },

                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text('Forgot Password?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xff1F1D1C),
                                )),
                          ),
                        ),
                        const CustomSwitchTile(),
                        const SizedBox(height: 50),
                        LoginButton(
                          text: controller.isLoadingForLogin.isTrue ? 'Signing In...' : 'SIGN IN',
                          onPressed:() {
                            if (controller.loginFormKey.currentState!.validate()) {
                              controller.login();
                            }
                          },
                        ),
                        const SizedBox(height: 150),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have account?",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                            InkWell(
                              onTap: () {
                                Get.to(() => SignUp());
                              },
                              child: const Text("Sign up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xff388175))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        InkWell(
                          onTap: () {
                            Get.to(() => const FindYourAccountScreen(type: 1));
                          },
                          child: const Text("Do you need to verify your email",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(0xff388175))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}


