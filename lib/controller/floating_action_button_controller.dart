import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingActionButtonController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  RxBool isOpen = false.obs;
  Rx<MaterialColor> iconColor = Colors.grey.obs as Rx<MaterialColor>;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void toggle() {
    isOpen.value = !isOpen.value;
    iconColor.value = isOpen.value ? Colors.teal : Colors.grey as MaterialColor;
    isOpen.value ? controller.forward() : controller.reverse();
  }
}
