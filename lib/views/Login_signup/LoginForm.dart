import 'package:flutter/material.dart';
import 'package:on_bording/core/Components/functions.dart';

import '../../core/Widgets/InputField.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.email,
    required this.password,
  });

  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InputField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an email address';
              } else if (!RegExp(
                  r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            label: "Email",
            hintLabel: 'Email address',
            controller: email,
            icon: Icons.email_outlined),
        InputField(
            controller: password,
            validator: passwordValidator,
            hintLabel: 'Password',
            label: "Password",
            isPasswordField: true,
            icon: Icons.lock_outlined),
      ],
    );
  }
}