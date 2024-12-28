import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/volunteercontroller.dart';

import '../../controller/HomeController.dart';
import '../../core/Widgets/HomeOrganizationCard.dart';
import 'done_screen.dart';

class IndividualsCardListView extends StatelessWidget {
  const IndividualsCardListView({super.key, required this.volunteerController});

  final VolunteerController volunteerController;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.sizeOf(context).width * 0.25;
    double size = maxWidth < 40.0 ? maxWidth : 40.0;

    // Obtain the HomeController
    final HomeController homeController = Get.find<HomeController>();

    return SizedBox(
      height: 225,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: volunteerController.volunteers.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var volunteer = volunteerController.volunteers[index];

          return AspectRatio(
            aspectRatio: 135 / 202,
            child: HomeOrganizationCard(
              imageType: ClipOval(
                child: Image.network(
                  volunteer.imageUrl, // Use model property
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
              ),
              title: volunteer.description,
              // Use model property
              logoName: volunteer.eventName,
              // Use model property
              city: volunteer.location,
              // Use model property
              time: volunteer.timeFrom,
              // Use model property
              date: volunteer.date,
              // Use model property
              onPressed: () async {
                bool success = await homeController.applyForPost(
                    volunteer.userId, volunteer.userId);
                if (success) {
                  Get.to(() => const DoneScreen());
                }
              },
              buttonLabel: 'Apply',
            ),
          );
        },
      ),
    );
  }
}
