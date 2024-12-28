import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RateController extends GetxController {
  var rating = 3.0.obs; // Default initial rating
  var feedback = ''.obs;

  Future<void> updateRating(double newRating, String newFeedback, String userId,
      String volunteerId) async {
    rating.value = newRating;
    feedback.value = newFeedback;

    var userDoc =
        FirebaseFirestore.instance.collection('users').doc(volunteerId);

    // Update the volunteer's rate field and feedback in the user document
    await userDoc.update({
      'rate': rating.value,
      'feedback': feedback.value,
    });

    // Delete the volunteerId from MyVolunteers in the user's document
    var myVolunteersCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('MyVolunteers');
    var querySnapshot = await myVolunteersCollection
        .where('volunteerId', isEqualTo: volunteerId)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
