import 'package:cloud_firestore/cloud_firestore.dart';

class DonationDetail {
  final String eventName;
  final String description;
  final String location;
  final int goal;
  final String organizationName;
  final String category;
  final String startDate;
  final String endDate;
  final String imageUrl;

  DonationDetail({
    required this.eventName,
    required this.description,
    required this.location,
    required this.goal,
    required this.organizationName,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
  });

  factory DonationDetail.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return DonationDetail(
      eventName: data['eventname'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      goal: data['goal'] ?? 0,
      organizationName: data['organizationName'] ?? '',
      category: data['category'] ?? '',
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
