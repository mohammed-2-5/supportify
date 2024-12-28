import 'package:flutter/material.dart';
import 'package:on_bording/core/Widgets/InputField.dart';

import '../Login_signup/login_screen.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            const   Text('New password',style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.w600,fontSize: 24
            ),),
            const Text('Create Your New Password', style: TextStyle(fontSize: 14.0,color: Color(0xffBBBBBB),fontWeight: FontWeight.w500)),
            const SizedBox(height: 8.0),
            const InputField(label: 'Password', icon: Icons.lock_outline, hintLabel: 'Password',isPasswordField: true,),
            const SizedBox(height: 8.0),
            const InputField(label: 'Confirm Password', icon: Icons.lock_outline, hintLabel: 'Confirm Password',isPasswordField: true,),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  LoginScreen(),));
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 15)),
                fixedSize: MaterialStateProperty.all<Size>(const Size(double.maxFinite, 48)), // Adjusts button size within the container
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff388175)), // Makes the button itself transparent
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
