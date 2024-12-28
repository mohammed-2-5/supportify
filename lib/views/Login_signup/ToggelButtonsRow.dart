import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/RegisterController.dart';

import 'CustomToggelButton.dart';


class ToggleButtonsRow extends StatelessWidget {
  final RxInt selectedIndex;

  final RegisterController controller = Get.find();

   ToggleButtonsRow({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using Obx here to listen to changes in selectedIndex
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomToggleButton(
          title: 'Organization',
          isSelected: selectedIndex.value == 0,
          onPressed: () {
            controller.selectedIndex.value = 0;
            controller.selectedType=controller.selectedIndex;
          },
        ),
        CustomToggleButton(
          title: 'Individual',
          isSelected: selectedIndex.value == 1,
          onPressed: () {
            controller.selectedIndex.value = 1;
            controller.selectedType=controller.selectedIndex;
          },
        ),
      ],
    ));
  }
}
