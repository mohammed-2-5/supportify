import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/rate_controller.dart';

class RateScreen extends StatelessWidget {
  final String volunteerId;
  final String userId;

  RateScreen({Key? key, required this.volunteerId, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RateController controller = Get.put(RateController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rate Volunteer',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/arrow_back.svg'),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RatingBar.builder(
              initialRating: controller.rating.value,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                controller.rating.value = rating;
              },
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => controller.feedback.value = value,
              decoration: const InputDecoration(
                labelText: 'Feedback',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.updateRating(controller.rating.value,
                    controller.feedback.value, userId, volunteerId);
                Get.back(); // Navigate back after updating rating and deleting volunteerId
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
