import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
   const CustomElevatedButton({
    super.key, required this.onPressed, required this.title, this.width,
  });
  final VoidCallback? onPressed;
  final String title;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 15)),
        fixedSize: MaterialStateProperty.all<Size>( Size(width??double.maxFinite, 48)), // Adjusts button size within the container
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff388175)), // Makes the button itself transparent
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      child:  Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
