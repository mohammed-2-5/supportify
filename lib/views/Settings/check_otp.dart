import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/RegisterController.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class CheckOtp extends StatefulWidget {
  const CheckOtp({Key? key}) : super(key: key);

  @override
  State<CheckOtp> createState() => _CheckOtpState();
}

class _CheckOtpState extends State<CheckOtp> {
  Timer? _timer;
  int _currentTime = 90; // 1 minute and 30 seconds

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
          Get.back();
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

    super.dispose();
  }
  final RegisterController controller=Get.find();
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
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Confirm Your Email', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24)),
            const Text('Write down confirmation code ', style: TextStyle(fontSize: 14.0, color: Color(0xffBBBBBB), fontWeight: FontWeight.w500)),
            const SizedBox(height: 8.0),
            OTPTextField(
              length: 5,
              width: MediaQuery.of(context).size.width,
              fieldWidth: MediaQuery.of(context).size.width * 0.13,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                controller.otpField.value = pin ; // Make sure this variable is an observable
                print("Completed: ${controller.otpField.value}");
              },
            ),

            const SizedBox(height: 20.0),
            Text(timerText, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await controller.verifyOtp(controller.otpField.value);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 15)),
                fixedSize: MaterialStateProperty.all<Size>(const Size(double.maxFinite, 48)),
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff388175)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child: const Text('Continue', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}



