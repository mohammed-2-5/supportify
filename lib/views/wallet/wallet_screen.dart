import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../WalletExchange/wallet_exchange.dart';
import 'BalanceContainer.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/arrow back.svg'),
            onPressed: () => Get.back(),
          ),
          actions: [
            RotatedBox(
              quarterTurns: 90,
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/arrow back.svg',
                ),
                onPressed: () {
                  Get.to(WalletExchange());
                },
              ),
            ),
          ],
          title: const Text('Wallet',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BalanceContainer(),
                // const SizedBox(
                //   height: 30,
                // ),
                // const Text(
                //   'Recent Activity',
                //   style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.w400,
                //       color: Color(0xff1F1D1C)),
                // ),
                // const SizedBox(
                //   height: 40,
                // ),
                // const Text(
                //   'Today',
                //   style: TextStyle(
                //       fontSize: 15,
                //       fontWeight: FontWeight.w500,
                //       color: Color(0xff1F1D1C)),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // const NotificationTile(
                //   userName: 'Khaled',
                //   userImage: 'assets/Ellipse 1226.jpg',
                //   message: 'Thank you agin for the assest  .',
                //   time: '2 minutes ago',
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
