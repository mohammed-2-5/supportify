import 'package:flutter/material.dart';

import '../../views/Home/CardFormData.dart';
import 'CustomButton.dart';
import 'LogoRow.dart';

class HomeOrganizationCard extends StatelessWidget {
  const HomeOrganizationCard(
      {super.key,
      required this.title,
      required this.logoName,
      required this.city,
      required this.time,
      required this.date,
      this.buttonLabel,
      this.onPressed,
      required this.imageType});

  final Widget imageType;
  final String title;
  final String logoName;
  final String city;
  final String time;
  final String date;
  final String? buttonLabel;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Set the borderRadius to 15
      ),
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoRow(
              imageType: imageType,
              logoName: logoName,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(
              height: 5,
            ),
            CardFormData(
              city: city,
              time: time,
              date: date,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              label: buttonLabel,
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}
