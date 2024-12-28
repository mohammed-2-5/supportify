
import 'package:flutter/material.dart';

import '../Settings/ThankYouScreen.dart';



class ContactUsMessage extends StatelessWidget {
  const ContactUsMessage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Contact Us',style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Full Name',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
              const SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
              ),
              const SizedBox(height: 20,),
              const Text('Message',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
              const SizedBox(height: 8,),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: 'Enter Your Message ...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ThankYouScreen(),));
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 15)),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(double.maxFinite, 48)), // Adjusts button size within the container
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff388175)), // Makes the button itself transparent
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
// Padding(
// padding:  EdgeInsets.zero,
// child: Container(
// decoration: const BoxDecoration(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(40), topRight: Radius.circular(40)),
// color: Colors.white,
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
// child: SingleChildScrollView(
// child: Column(
// children: <Widget>[
// Column(
// children: <Widget>[
// InputField(label: "Full name",
// hintLabel: 'Name',
// icon: Icons.text_fields_outlined),
// InputField(
// hintLabel: 'Message',
// label: "Enter Your message", icon: Icons.textsms_outlined),
// ],
// ),
// const SizedBox(height: 20),
// const SizedBox(height: 50),
// ElevatedButton(
// onPressed: () {
// Navigator.push(context, MaterialPageRoute(builder: (context) => const Home(),));
// },
// style: ButtonStyle(
// padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 15)),
// fixedSize: MaterialStateProperty.all<Size>(const Size(double.maxFinite, 48)), // Adjusts button size within the container
// backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff388175)), // Makes the button itself transparent
// shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12.0),
// ),
// ),
// ),
// child: const Text(
// 'Send',
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 16,
// color: Colors.white,
// ),
// ),
// ),

// const SizedBox(height: 150),
//
//
// ],
// ),
// ),
// ),
// ),
// )