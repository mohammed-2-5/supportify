import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/views/ContactUs/Contact%20Us.dart';

import '../Login_signup/login_screen.dart';
import '../Settings/change_password.dart';

enum Language { english, arabic }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Language _selectedLanguage = Language.english;
  //
  // void _showLanguageBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         decoration: const BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.all(Radius.circular(15))),
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             RadioListTile<Language>(
  //               title: const Text('English'),
  //               value: Language.english,
  //               groupValue: _selectedLanguage,
  //               onChanged: (Language? value) {
  //                 setState(() {
  //                   _selectedLanguage = value!;
  //                 });
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             RadioListTile<Language>(
  //               title: const Text('Arabic'),
  //               value: Language.arabic,
  //               groupValue: _selectedLanguage,
  //               onChanged: (Language? value) {
  //                 setState(() {
  //                   _selectedLanguage = value!;
  //                 });
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // String languageText =
    //     _selectedLanguage == Language.english ? 'English' : 'Arabic';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Settings', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: ListTile.divideTiles(
            // This adds dividers between list items
            context: context,
            tiles: [
              // ListTile(
              //   title: Text(languageText),
              //   onTap: () => _showLanguageBottomSheet(), // Updated this line
              //   trailing: const Icon(Icons.arrow_forward_ios),
              // ),
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text('Change password'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePassword(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About us'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Handle the tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Contact Us'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Contactus(),
                      ));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.left,
                  ),
                  onTap: () async {
                    if (kDebugMode) {
                      print('Logout button pressed');
                    } // Debug output to ensure this function is called
                    await FirebaseAuth.instance.signOut();
                    Get.offAll(LoginScreen());
                  },
                ),
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}
