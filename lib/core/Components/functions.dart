
import 'package:flutter/material.dart';

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  // Regex pattern to check if the password contains at least one digit
  RegExp hasNumber = RegExp(r'[0-9]');
  if (!hasNumber.hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  // Regex pattern to check if the password contains at least one uppercase letter
  RegExp hasUpper = RegExp(r'[A-Z]');
  if (!hasUpper.hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  // Regex pattern to check if the password contains at least one special character
  RegExp hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  if (!hasSpecialCharacters.hasMatch(value)) {
    return 'Password must contain special characters like !@#%^&*(),.?":{}|<>';
  }
  return null; // Correctly typed return for String?
}
enum Language { english, arabic }

void showLanguageBottomSheet(BuildContext context,{
  required void Function(Language?)? onChanged,
  required Language selectedLanguage
}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration:const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RadioListTile<Language>(
              title: const Text('English'),
              value: Language.english,
              groupValue: selectedLanguage,

              onChanged: onChanged
            ),
            RadioListTile<Language>(
              title: const Text('Arabic'),
              value: Language.arabic,
              groupValue: selectedLanguage,
              onChanged: onChanged
            ),
          ],
        ),
      );
    },
  );
}