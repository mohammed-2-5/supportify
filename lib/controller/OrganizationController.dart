import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrganizationController extends GetxController {
  var organizations = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var organizationIds = <String>[].obs;

  Future<void> addOrganization({
    required String eventName,
    required String description,
    required String date,
    required String location,
    required String phone,
    required String email,
    required int organizationCount,
    required String timeFrom,
    required String timeTo,
    required String? imageUrl,
  }) async {
    isLoading(true);
    try {
      CollectionReference collRef =
          FirebaseFirestore.instance.collection('organizations');
      await collRef.add({
        "eventname": eventName,
        "description": description,
        "date": date,
        "location": location,
        "phone": phone,
        "email": email,
        "volunteer": organizationCount,
        "_timeFrom": timeFrom,
        "_timeTo": timeTo,
        "imageUrl": imageUrl,
        'userId': FirebaseAuth.instance.currentUser?.uid,
        // Confirm imageUrl is used here
      });
      Get.snackbar('Success', 'Organization added successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print("FireStore add failed: $e"); // More detailed error logging
      Get.snackbar('Error', 'Failed to add volunteer: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrganizations();
  }

  Future<OrganizationController> init() async {
    await fetchOrganizations();
    return this;
  }

  Future<void> fetchOrganizations() async {
    isLoading(true);
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('organizations').get();
      organizationIds.assignAll(snapshot.docs.map((doc) => doc.id).toList());
      print(organizationIds[0] + '/////////');
      organizations.assignAll(
          snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>));
    } finally {
      isLoading(false);
    }
  }

// var filteredOrganizations = <Map<String, dynamic>>[].obs;
//
// Future<void> fetchFilteredOrganizations(List<String> postIds) async {
//   isLoading(true);
//   try {
//     var snapshot =
//         await FirebaseFirestore.instance.collection('organizations').get();
//     filteredOrganizations.assignAll(snapshot.docs
//         .where((doc) => postIds.contains(doc.id))
//         .map((doc) => doc.data() as Map<String, dynamic>)
//         .toList());
//     print(
//         'Filtered Volunteers: ${filteredOrganizations.length}'); //Debugging line
//   } finally {
//     isLoading(false);
//   }
// }
}
