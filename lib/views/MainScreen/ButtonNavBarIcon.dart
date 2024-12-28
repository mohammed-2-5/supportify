import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonNavBarIcon extends StatelessWidget {
  const ButtonNavBarIcon({
    super.key, required this.size, required this.data, required this.onTap, required this.color,
  });
  final double size ;
  final String data;
  final VoidCallback onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        icon:  SvgPicture.asset(data,height: size,width: size,color: color,));
  }
}
