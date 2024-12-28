import 'package:get/get.dart';
import 'package:on_bording/controller/HomeController.dart';
import 'package:on_bording/controller/OrganizationController.dart';
import 'package:on_bording/controller/RegisterController.dart';
import 'package:on_bording/controller/change_password_controller.dart';
import 'package:on_bording/controller/login_controller.dart';
import 'package:on_bording/controller/qr_controller.dart';
import 'package:on_bording/controller/rate_controller.dart';

import '../../controller/donation_contoller.dart';
import '../../controller/volunteercontroller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
    Get.put(LoginController());
    Get.put(HomeController());
    Get.put(VolunteerController());
    Get.put(OrganizationController());
    Get.put(DonateTaskController());
    Get.put(RateController());
    Get.put(QRController());
    Get.put(PasswordController());
  }
}
