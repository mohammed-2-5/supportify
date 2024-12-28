import 'package:flutter/material.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      // Adjust for your padding needs
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the text and the button
        children: <Widget>[
           Text(
           title,
            style: const TextStyle(
              fontSize: 16, // Adjust the size to match your design
              fontWeight: FontWeight.bold, // Use FontWeight as needed
              color: Colors.black, // Change the color as needed
            ),
          ),
          TextButton(
            onPressed: () {
              // Insert the action for the button here
            },

            child: const Text(
              'View All',
              style: TextStyle(
                color: Color(0xff388175), // Change the color to match your design
              ),
            ),
          ),
        ],
      ),
    );
  }
}
