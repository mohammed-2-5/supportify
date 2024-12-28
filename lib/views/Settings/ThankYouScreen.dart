import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MainScreen/main_screen.dart';


class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  _ThankYouScreenState createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), navigateToMainScreen);
  }

  void navigateToMainScreen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("onboarding", false);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Thank you", style: TextStyle(fontSize: 50, color: Colors.black)),
      ),
    );
  }
}
