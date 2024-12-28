import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/OrganizationController.dart';
import 'package:on_bording/controller/volunteercontroller.dart';
import 'package:on_bording/views/Home/individuals_card_list_view.dart';
import 'package:on_bording/views/Home/organization_listview.dart';

import '../../controller/HomeController.dart';
import '../../core/Widgets/SearchBar.dart';
import 'HeaderRow.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final HomeController controller = Get.find();
  final VolunteerController volunteerController = Get.find();
  final OrganizationController organizationController = Get.find();

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.sizeOf(context).width * 0.25;
    double size = maxWidth < 50.0 ? maxWidth : 50.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          if (volunteerController.isLoading.isTrue &&
              controller.isLoading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      'Hi ${controller.userModel.value.username} ',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      'We are happy with your presence!',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    trailing: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: controller.userModel.value.imageUrl,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SearchBarWithBellIcon(),
                  const SizedBox(
                    height: 15,
                  ),
                  if (controller.userModel.value.type != 0) ...[
                    HomeOrganizationSection(
                      headerTitle: 'Organizations',
                      size: size,
                      organizationController: organizationController,
                      homeController: controller,
                    ),
                    const SizedBox(height: 20),
                  ],
                  const HeaderRow(
                    title: 'Individuals',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IndividualsCardListView(
                    volunteerController: volunteerController,
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
