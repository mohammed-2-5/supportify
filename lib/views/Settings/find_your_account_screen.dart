import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/otp_controller.dart';
import 'package:on_bording/core/Widgets/InputField.dart';

import '../../controller/RegisterController.dart';
import '../../controller/login_controller.dart';
import 'ConfirmYourEmailScreen.dart';

class FindYourAccountScreen extends StatefulWidget {
  final int type;

  const FindYourAccountScreen({super.key, required this.type});

  @override
  _FindYourAccountScreenState createState() => _FindYourAccountScreenState();
}

class _FindYourAccountScreenState extends State<FindYourAccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = false;
  final RegisterController registerController = Get.find();
  final LoginController loginController = Get.find();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    _emailController.removeListener(_onEmailChanged);
    _emailController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    setState(() {
      _isEmailValid = _isValidEmail(_emailController.text);
    });
  }

  bool _isValidEmail(String email) {
    // Simple regex for email validation
    final emailRegex = RegExp(r'^\S+@\S+\.\S+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (registerController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }else{
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Find Your Account', style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24
                ),),
                const Text('Type your Email', style: TextStyle(fontSize: 14.0,
                    color: Color(0xffBBBBBB),
                    fontWeight: FontWeight.w500)),
                const SizedBox(height: 8.0),
                InputField(label: 'Email',
                  icon: Icons.email_outlined,
                  hintLabel: 'Write your email',
                  controller: _emailController,),

                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _isEmailValid ? () async {
                    if (widget.type == 1) {
                      if (kDebugMode) {
                        print(_emailController.text.trim());
                      }
                      registerController.sendOtp(_emailController.text.trim());
                      Get.offAll(ConfirmYourEmailScreen(
                        type: widget.type, email: _emailController.text.trim(),));
                    } else if (widget.type == 0) {
                      await loginController.resetPassword(email: _emailController
                          .text.trim(), context: context);
                    }
                  }
                      : null,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color(0xffBFC7C6); // Disable color
                        }
                        return _isEmailValid
                            ? const Color(0xff388175)
                            : const Color(
                            0xffBFC7C6); // Use the condition to determine the color
                      },
                    ),
                  ),
                  child: const Text(
                    'Continue', style: TextStyle(color: Colors.white),),
                ),
              ],
            );
          }


        }),
      ),
    );
  }
}