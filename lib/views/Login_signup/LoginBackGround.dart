import 'package:flutter/material.dart';

class LoginBackGround extends StatelessWidget {
  const LoginBackGround({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.7,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff388175),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 50), // Add padding for the overall column
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back!',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5), // Spacing between the two texts
            Text(
              'Log back into your account',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}