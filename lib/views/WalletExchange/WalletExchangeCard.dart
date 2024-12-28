import 'package:flutter/material.dart';
import 'package:on_bording/core/Widgets/CustomButton.dart';
import 'package:on_bording/core/Widgets/LogoRow.dart';


class WalletExchangeCard extends StatelessWidget {
  const WalletExchangeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.sizeOf(context).width * 0.25;
    double size = maxWidth < 40.0 ? maxWidth : 40.0;
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Set the borderRadius to 15
      ),
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             LogoRow(
              imageType: Image.asset('assets/Orange.png',width:size ,height:size ,),

              logoName: 'Orange',
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Purchase Voucher',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              '100 EGP',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              label: 'Redeem',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
