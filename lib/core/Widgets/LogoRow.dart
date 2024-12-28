
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FormDataRow.dart';

class LogoRow extends StatelessWidget {
  const LogoRow({
    super.key,  required this.logoName, required this.imageType,
  });

  final String logoName;
  final Widget imageType;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the size of the logo based on the screen width
         // Example: logo can take up to 15% of the width

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            imageType,
            Text(
              logoName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: responsiveFontSize(context, 13), // Use the responsive font function
              ),
            ),
          ],
        );
      },
    );
  }
}


