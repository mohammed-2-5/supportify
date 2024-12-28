import 'package:flutter/material.dart';
import 'package:on_bording/core/Components/color.dart';




class MainCategoryItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onPressed;

  const MainCategoryItem(
      {super.key,
      required this.title,
      required this.iconPath,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 153,
        height: 135,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: .3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 40, height: 40, color: primaryColor),
            const SizedBox(height: 5.0),
            Text(
              title,
              style: const TextStyle(fontSize: 18, color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
