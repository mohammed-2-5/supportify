import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/HomeController.dart';

import '../../controller/donation_contoller.dart';
import 'OrganizationsListScreen.dart';

class EducationScreen extends StatelessWidget {
  final String categoryName;

  EducationScreen({super.key, required this.categoryName});

  final DonateTaskController controller = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff388175),
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/arrow back.svg',
                color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff388175), Color(0xff388175)],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 35),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryName,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          '"Learn, Grow, Succeed"',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Obx(() {
                        if (controller.donations.isEmpty) {
                          return const Center(
                            child:
                                Text('No donations found for this category.'),
                          );
                        }

                        return Column(
                          children: [
                            OrganizationListView(
                                organizations: controller.donations),
                            const SizedBox(
                              height: 100,
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
