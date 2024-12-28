import 'package:flutter/material.dart';


import 'VolunteerTaskForm.dart';

class VolunteerTaskPage extends StatelessWidget {
  const VolunteerTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
      icon: const Icon(Icons.arrow_back,color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
        title: const Text('Volunteering task ',style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
        ),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:  SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: VolunteerTaskForm(),
      ),
    );
  }
}

