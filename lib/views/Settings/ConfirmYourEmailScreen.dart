import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/RegisterController.dart';
import 'package:on_bording/controller/otp_controller.dart';
import 'package:on_bording/views/Settings/find_your_account_screen.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'dart:async';


class ConfirmYourEmailScreen extends StatefulWidget {
  const ConfirmYourEmailScreen({super.key, required this.type, required this.email});
  final int type;
  final String email;
  @override
  _ConfirmYourEmailScreenState createState() => _ConfirmYourEmailScreenState();
}

class _ConfirmYourEmailScreenState extends State<ConfirmYourEmailScreen> {
  final RegisterController registerController = Get.find();
   final TextEditingController controller=TextEditingController() ;
  Timer? _timer;
  int _currentTime = 90; // 1 minute and 30 seconds
  EmailOTP myAuth = EmailOTP();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentTime == 0) {
        timer.cancel();
        if (mounted) {
          Get.offAll(const FindYourAccountScreen(type: 1));
        }
      } else {
        setState(() {
          _currentTime--;
        });
      }
    });
  }

  String get timerText {
    final minutes = (_currentTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_currentTime % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Confirm Your Email',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 24)),
            const Text('Write down confirmation code ',
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xffBBBBBB),
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 8.0),
            OTPTextField(
              length: 5,
              width: MediaQuery.of(context).size.width,
              fieldWidth: MediaQuery.of(context).size.width * 0.12,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onChanged: (pin) {
                registerController.otpField.value =
                    pin; // Make sure this variable is an observable
                print("Completed: ${registerController.otpField.value}");
              },
            ),
            const SizedBox(height: 20.0),
            Text(timerText,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(height: 20.0),
            ElevatedButton(

              onPressed: () async {
              await registerController.verifyOtp(widget.email);
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
                  const Text('Continue', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

}
