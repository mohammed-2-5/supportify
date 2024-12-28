import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchFormField extends StatelessWidget {
  const SearchFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100, // Assuming a white background
        borderRadius: BorderRadius.circular(15.0), // Adjust for roundness
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4), // Adjust offset for vertical positioning
          ),
        ],
      ),
      child: TextFormField(
        decoration:  InputDecoration(
          icon: SvgPicture.asset('assets/search.svg'),
          hintText: 'Search',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
