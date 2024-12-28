import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.details});

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TextButton(
          onPressed: () {
            print(details['location']);
            print(details['description']);
          },
          child: Text('Apply')),
    );
  }
}
