import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/volunteer_model.dart';
import 'HomeController.dart';

class VolunteerController extends GetxController {
  var volunteers = <Volunteer>[].obs; // List of Volunteer model instances
  var volunteerIds = <String>[].obs;

  var isLoading = false.obs;

  // Form field controllers
  final eventNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final contactPhoneController = TextEditingController();
  final contactEmailController = TextEditingController();
  final dateController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  var volunteersCount = 1.obs; // Observable for volunteers count
  var timeFrom = TimeOfDay.now().obs;
  var timeTo = TimeOfDay.now().obs;
  var isPicked = false.obs;
  var timeToPicked = ''.obs;
  var timeFromPicked = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVolunteers();
  }

  Future<VolunteerController> init() async {
    await fetchVolunteers();
    return this;
  }

  Future<void> addVolunteer() async {
    isLoading(true);
    try {
      CollectionReference collRef =
          FirebaseFirestore.instance.collection('volunter');
      final volunteer = Volunteer(
        eventName: eventNameController.text,
        description: descriptionController.text,
        location: locationController.text,
        phone: phoneController.text,
        email: emailController.text,
        date: dateController.text,
        volunteersCount: volunteersCount.value,
        timeFrom: timeFrom.value.format(Get.context!),
        timeTo: timeTo.value.format(Get.context!),
        imageUrl: Get.find<HomeController>().userModel.value.imageUrl,
        userId: FirebaseAuth.instance.currentUser?.uid ?? '',
      );
      await collRef.add(volunteer.toMap());
      Get.snackbar('Success', 'Volunteer added successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add volunteer: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchVolunteers() async {
    isLoading(true);
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('volunter').get();
      volunteerIds.assignAll(snapshot.docs.map((doc) => doc.id).toList());

      volunteers.assignAll(
        snapshot.docs.map((doc) => Volunteer.fromFirestore(doc)).toList(),
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isFrom ? timeFrom.value : timeTo.value,
    );
    if (pickedTime != null) {
      if (isFrom) {
        timeFrom.value = pickedTime;
        timeFromPicked.value = '${pickedTime.hour}:${pickedTime.minute}';
      } else {
        timeTo.value = pickedTime;
        timeToPicked.value = '${pickedTime.hour}:${pickedTime.minute}';
      }
      isPicked.value = true;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      dateController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
    }
  }
}
