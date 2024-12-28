import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/donation_details_model.dart';
import '../views/Settings/ThankYouScreen.dart';

class DonateTaskController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Initialize form field controllers
  final eventNameController = TextEditingController(text: 'Donation Task');
  final descriptionController = TextEditingController();
  final locationController = TextEditingController(text: 'Donation Task');

  var categories = <QueryDocumentSnapshot>[].obs; // Categories from Firestore
  var selectedCategory = ''.obs; // Selected category
  var donations = <DonationDetail>[].obs; // Donations for the selected category

  var myCategory = ''.obs; // Selected category

  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;
  var isPickedStartDate = false.obs;
  var isPickedEndDate = false.obs;
  var goal = 100.obs; // Default value for goal
  var goals = <int>[].obs; // List of goals from Firestore

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Fetch categories from Firestore
    fetchGoals();
  }

  Future<void> fetchCategories() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    categories.value = snapshot.docs;
  }

  Future<void> fetchGoals() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('donationGoals').get();
    if (snapshot.docs.isNotEmpty) {
      goals.value = List<int>.from(snapshot.docs.first['goals']);
      // Set default goal value to the first goal in the list if it exists
      if (goals.isNotEmpty) {
        goal.value = goals.first;
      }
    }
  }

  var isLoading = false.obs;

  Future<void> fetchDonations(String category) async {
    try {
      if (kDebugMode) {
        print("Fetching donations for category: $category");
      }
      isLoading.value = true; // Debugging statement
      var snapshot = await FirebaseFirestore.instance
          .collection('Donation')
          .where('category', isEqualTo: category)
          .get();

      if (snapshot.docs.isEmpty) {
        if (kDebugMode) {
          print("No donations found for category: $category");
        } // Debugging statement
      } else {
        if (kDebugMode) {
          print("Donations fetched: ${snapshot.docs.length}");
        } // Debugging statement
      }

      donations.value = snapshot.docs
          .map((doc) => DonationDetail.fromFirestore(doc))
          .toList();

      // Print each donation to check the data
      for (var donation in donations) {
        print("Donation: ${donation.eventName}, ${donation.description}");
      }
    } catch (e) {
      print("Error fetching donations: $e"); // Debugging statement
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? startDate.value : endDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      if (isStartDate) {
        startDate.value = pickedDate;
        isPickedStartDate.value = true;
      } else {
        endDate.value = pickedDate;
        isPickedEndDate.value = true;
      }
    }
  }

  void addDonationTask(
      BuildContext context, String imageUrl, String organizationName) {
    if (formKey.currentState?.validate() ?? false) {
      CollectionReference collRef =
          FirebaseFirestore.instance.collection('Donation');
      collRef.add({
        "eventname": eventNameController.text,
        "description": descriptionController.text,
        'goal': goal.value,
        "startDate": DateFormat('dd/MM/yyyy').format(startDate.value),
        "endDate": DateFormat('dd/MM/yyyy').format(endDate.value),
        "category": selectedCategory.value,
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'location': locationController.text,
        'imageUrl': imageUrl,
        'organizationName': organizationName
      }).then((_) {
        Get.snackbar('Success', 'Donation Task added successfully');
        Get.offAll(() => const ThankYouScreen());
      });
    }
  }

  void reset() {
    eventNameController.text = 'Donation Task';
    descriptionController.clear();
    categories.clear();
    selectedCategory.value = '';
    startDate.value = DateTime.now();
    endDate.value = DateTime.now();
    isPickedStartDate.value = false;
    isPickedEndDate.value = false;
    locationController.clear();
    goal.value = 100;
    goals.clear();
  }

  @override
  void onClose() {
    reset();
    super.onClose();
  }

  @override
  void dispose() {
    eventNameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }
}
