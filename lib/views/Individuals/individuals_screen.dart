import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Settings/rate.dart';
import 'SearchFormField.dart';
import 'volunteer_card.dart'; // Import the VolunteerCard widget

class IndividualsScreen extends StatelessWidget {
  const IndividualsScreen({super.key});

  Future<List<Map<String, dynamic>>> getMyVolunteers() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('MyVolunteers')
        .get();
    List<Map<String, dynamic>> volunteers = snapshot.docs.map((doc) {
      var data = doc.data();
      data['volunteerId'] =
          doc['volunteerId']; // Correctly assign the volunteerId field
      return data;
    }).toList();
    print('Volunteers: $volunteers'); // Debugging line
    return volunteers;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Individuals',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 15),
              const SearchFormField(),
              const SizedBox(height: 24),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: getMyVolunteers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final volunteers = snapshot.data!;
                    return ListView.builder(
                      itemCount: volunteers.length,
                      itemBuilder: (context, index) {
                        final volunteer = volunteers[index];
                        String userId = FirebaseAuth.instance.currentUser!.uid;
                        return VolunteerCard(
                          imageUrl: volunteer['imageUrl'],
                          name: volunteer['name'],
                          email: volunteer['email'],
                          onTap: () {
                            print(volunteer['volunteerId'] + '////////'); //
                            Get.to(() => RateScreen(
                                  volunteerId: volunteer['volunteerId'],
                                  userId: userId,
                                ));
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
