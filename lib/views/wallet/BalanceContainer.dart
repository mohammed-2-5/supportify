import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/HomeController.dart';

import '../Settings/withdraw_screen.dart';

class BalanceContainer extends StatelessWidget {
  BalanceContainer({
    super.key,
  });

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Your Points',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff4F4F4F)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${homeController.userModel.value.totalPoints}',
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff333333)),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => WithdrawScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff388175),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Withdraw',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFDFDFD),
                      fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 50),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       RichText(
          //         text: const TextSpan(
          //           text: 'Approved\n',
          //           style: TextStyle(fontSize: 12, color: Color(0xff4F4F4F)),
          //           children: <TextSpan>[
          //             TextSpan(
          //               text: '\$236',
          //               style: TextStyle(
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.w400,
          //                   color: Color(0xff388175)),
          //             ),
          //           ],
          //         ),
          //       ),
          //       RichText(
          //         text: const TextSpan(
          //           text: 'Pending\n',
          //           style: TextStyle(fontSize: 12, color: Color(0xff4F4F4F)),
          //           children: <TextSpan>[
          //             TextSpan(
          //               text: '\$200',
          //               style: TextStyle(
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.w400,
          //                   color: Color(0xff388175)),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
