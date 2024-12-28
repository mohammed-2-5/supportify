import 'package:cloud_firestore/cloud_firestore.dart';

class Volunteer {
  final String eventName;
  final String description;
  final String location;
  final String phone;
  final String email;
  final String date;
  final int volunteersCount;
  final String timeFrom;
  final String timeTo;
  final String imageUrl;
  final String userId;

  Volunteer({
    required this.eventName,
    required this.description,
    required this.location,
    required this.phone,
    required this.email,
    required this.date,
    required this.volunteersCount,
    required this.timeFrom,
    required this.timeTo,
    required this.imageUrl,
    required this.userId,
  });

  // Convert Firestore document to a Volunteer object
  factory Volunteer.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Volunteer(
      eventName: data['eventname'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      date: data['date'] ?? '',
      volunteersCount: data['volunteer'] ?? 1,
      timeFrom: data['_timeFrom'] ?? '',
      timeTo: data['_timeTo'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

  // Convert Volunteer object to a Map (to store in Firestore)
  Map<String, dynamic> toMap() {
    return {
      "eventname": eventName,
      "description": description,
      "location": location,
      "phone": phone,
      "email": email,
      "date": date,
      "volunteer": volunteersCount,
      "_timeFrom": timeFrom,
      "_timeTo": timeTo,
      "imageUrl": imageUrl,
      'userId': userId,
    };
  }
}
