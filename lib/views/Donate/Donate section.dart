import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/donation_contoller.dart';
import 'package:on_bording/views/Donate/education_screen.dart';

import '../../controller/HomeController.dart';
import '../../core/Widgets/SearchBar.dart';
import 'Main_categort_item.dart';

class DonateSection extends StatelessWidget {
  DonateSection({Key? key}) : super(key: key);
  final DonateTaskController donateTaskController = Get.find();
  final HomeController homeController = Get.find();
  final List<String> path = [
    'assets/images/cil_education.png',
    'assets/images/hert.png',
    'assets/images/or.png',
    'assets/images/l.png',
    'assets/logo.png',
    'assets/images/on.png'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          if (homeController.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      'Hi ${homeController.userModel.value.username} ',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      'We are happy with your presence!',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    trailing: CircleAvatar(
                      radius: 25,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: homeController.userModel.value.imageUrl,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        crossAxisCount: 2,
                      ),
                      itemCount: donateTaskController.categories.length,
                      itemBuilder: (context, int index) {
                        var category = donateTaskController.categories[index];
                        return MainCategoryItem(
                          title: category['categoryName'],
                          iconPath: path[index],
                          // Placeholder icon
                          onPressed: () {
                            donateTaskController.myCategory.value =
                                category['categoryName'];
                            print(donateTaskController.myCategory.value);
                            donateTaskController.fetchDonations(
                                donateTaskController.myCategory.value);
                            Get.to(() => EducationScreen(
                                categoryName: category['categoryName']));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
