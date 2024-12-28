import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/auth_controller.dart';
import 'package:on_bording/controller/login_controller.dart';
import 'package:on_bording/views/Onboboarding/onboarding_view.dart';
import 'package:on_bording/views/MainScreen/main_screen.dart';


class SplashScreen extends StatefulWidget {
  @override


  const SplashScreen({super.key,});
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginController controller=Get.find();

  @override
  void initState() {
    super.initState();
    _initialize();
  }
  Future<void> _initialize() async {
    await controller.loadLoginState;
    Timer(
      const Duration(seconds: 3),
          () {
        if (controller.isLoggedIn.value) {
          print(controller.isLoggedIn);
          Get.offAll(const MainScreen());
        } else {
          print(controller.isLoggedIn.value);
          Get.offAll(const OnboardingView());
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFF388175), Color(0xFF388175),]
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo.png",
                  color: const Color(0xffFFFFFF),
                ),
                AnimatedTextKit(

                  animatedTexts: [
                    TyperAnimatedText('Supportify',
                        speed: const Duration(milliseconds: 150),
                        textStyle: const TextStyle(
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.w700,
                            fontSize: 40)),

                  ],
                ),
              ],
            ),
            ),
        );
    }
}