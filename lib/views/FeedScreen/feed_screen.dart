import 'package:flutter/material.dart';

import '../Settings/ThankYouScreen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

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
          title: const Text('Feed Post',style: TextStyle(color: Colors.black),),
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
              const Text('Event Name',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
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
              const Text('Description',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
              const SizedBox(height: 8,),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Enter Your Data ...',
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
