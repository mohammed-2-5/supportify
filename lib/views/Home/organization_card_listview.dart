import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/HomeController.dart';
import 'package:on_bording/controller/OrganizationController.dart';

import '../../core/Widgets/HomeOrganizationCard.dart';
import 'done_screen.dart';

class OrganizationCardListView extends StatelessWidget {
  const OrganizationCardListView(
      {Key? key,
      required this.organizationController,
      required this.homeController})
      : super(key: key);
  final OrganizationController organizationController;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.sizeOf(context).width * 0.25;
    double size = maxWidth < 40.0 ? maxWidth : 40.0;
    return SizedBox(
      height: 225,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
        shrinkWrap: true,
        // Use inside SingleChildScrollView
        physics: const BouncingScrollPhysics(),
        // Disables scrolling within the ListView
        itemCount: organizationController.organizations.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var organizationId = organizationController.organizationIds[index];

          var organizations = organizationController.organizations[index];
          var organizationUserId = organizations['userId'];
          return AspectRatio(
            aspectRatio: 135 / 202,
            child: HomeOrganizationCard(
              imageType: ClipOval(
                  child: CachedNetworkImage(
                imageUrl: organizations['imageUrl'],
                fit: BoxFit.cover,
                width: size,
                height: size,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )),
              title: organizations['description'],
              logoName: organizations['eventname'],
              city: organizations['location'],
              time: organizations['_timeFrom'],
              date: organizations['date'],
              onPressed: () async {
                bool success = await homeController.applyForPost(
                    organizationId, organizationUserId);
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
