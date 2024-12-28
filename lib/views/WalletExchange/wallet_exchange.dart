import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/HomeController.dart';
import 'package:on_bording/core/Widgets/SearchBar.dart';

import 'WalletExchangeCard.dart';

class WalletExchange extends StatelessWidget {
  WalletExchange({Key? key}) : super(key: key);
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/arrow back.svg'),
          onPressed: () => Get.back(),
        ),
        title: Text('Hello, ${controller.userModel.value.username}',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome Back!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Balance',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4F4F4F)),
                  ),
                  Text(
                    '\$15,567',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff333333)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SearchBarWithBellIcon(
              logo: 'assets/images/filter.svg',
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: (153 /
                      202), // Calculate an appropriate ratio based on your content
                ),
                itemCount: 4, // The number of cards in the grid
                itemBuilder: (context, index) {
                  // Using your custom HomeOrganizationCard widget
                  return WalletExchangeCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
