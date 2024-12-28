import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FormDataRow extends StatelessWidget {
  const FormDataRow({

    super.key, required this.logo, required this.title,
  });
  final String logo;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(logo),
        SizedBox(
          width: 5,
        ),
        Text(title,style: TextStyle(fontSize:responsiveFontSize(context, 13)),),
      ],
    );
  }
}
double responsiveFontSize(BuildContext context, double baseFontSize) {
  // This is the base width that your designs are based on
  double baseWidth = 375.0;

  // Minimum and maximum font size
  double minFontSize = 9.0;
  double maxFontSize = 13.0;

  // Get the current screen's width
  double screenWidth = MediaQuery.of(context).size.width;

  // Calculate the scale factor
  double scaleFactor = screenWidth / baseWidth;

  // Calculate the new font size based on the scale factor
  double newFontSize = baseFontSize * scaleFactor;

  // Clamp the new font size to the minimum and maximum values
  return newFontSize.clamp(minFontSize, maxFontSize);
}
