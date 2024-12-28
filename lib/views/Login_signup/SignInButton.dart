import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const SignUpButton({
    Key? key,
    required this.onPressed,
    this.text = 'SIGN UP',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 15),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size(double.maxFinite, 48), // Adjusts button size within the container
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xff388175), // Makes the button itself transparent
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
