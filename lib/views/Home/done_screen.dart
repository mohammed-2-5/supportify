import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/core/Widgets/CustomElevatedButton.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                fit: FlexFit.loose,
                child: Image.asset('assets/onboarding1.png')),
            const SizedBox(height: 15),
            const Text(
             'Thank you for your time ♥ .',
              style: TextStyle(
               decoration: TextDecoration.none,
                  color: Colors.black, fontSize: 17,
                   fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            const Text('You can do it we believe in you  ♥',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                    color: Color(0xff8A8A8A), fontSize: 15),
                textAlign: TextAlign.center),
            const SizedBox(height: 15),

            SizedBox(height: 70,),
            CustomElevatedButton(
               width: 270,
                onPressed: () {
                 Get.back();
            }, title: 'Done')
          ],
        ),
      ),
    );
  }
}
