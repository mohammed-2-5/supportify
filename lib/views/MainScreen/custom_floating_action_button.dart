import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/HomeController.dart';
import 'package:on_bording/views/FeedScreen/feed_screen.dart';
import 'package:on_bording/views/OrganizationScreen/organzation_task_page.dart';

import '../../controller/floating_action_button_controller.dart';
import '../DonateTask/donate_task_page.dart';
import '../VolunteerTaskScreen/volunteer_task_page.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final FloatingActionButtonController fabController =
      Get.put(FloatingActionButtonController());
  final HomeController homeController = Get.find();

  CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Obx(() {
          if (fabController.isOpen.value) {
            return AnimatedOpacity(
              opacity: fabController.isOpen.value ? 0.7 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: GestureDetector(
                onTap: fabController.toggle,
                child: Container(
                  color: Colors.black54,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            );
          }
          return Container();
        }),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Obx(() {
              if (fabController.isOpen.value) {
                return FadeTransition(
                  opacity: fabController.animation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        homeController.numberOfButtons.value * 2 - 1, (index) {
                      if (index % 2 == 1) return const SizedBox(width: 20);
                      return _buildCurvedOption(index ~/ 2, fabController);
                    }),
                  ),
                );
              }
              return Container();
            }),
            FloatingActionButton(
              onPressed: fabController.toggle,
              shape: const CircleBorder(),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: AnimatedIcon(
                color: fabController.iconColor.value,
                icon: AnimatedIcons.add_event,
                progress: fabController.animation,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCurvedOption(
      int index, FloatingActionButtonController fabController) {
    double angle = (index - 1) * 10; // Adjust angle for visual effect
    return Transform.rotate(
      angle: angle * 0.0174533, // Convert degrees to radians
      child: _buildOption(
          index == 0
              ? 'assets/paint.svg'
              : index == 1
                  ? 'assets/images/Vector.svg'
                  : 'assets/images/feed.svg',
          index == 0
              ? () {
                  homeController.userModel.value.type == 1
                      ? Get.to(() => const VolunteerTaskPage())
                      : Get.to(() => const OrganizationTaskPage());
                }
              : index == 1
                  ? () {
                      Get.to(() => const DonationTaskPage());
                    }
                  : () {
                      Get.to(const FeedScreen());
                    },
          'Tag$index',
          fabController),
    );
  }

  Widget _buildOption(String iconPath, VoidCallback onPressed, String tag,
      FloatingActionButtonController fabController) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      heroTag: tag,
      onPressed: onPressed,
      backgroundColor: Colors.white,
      child: Obx(() {
        return SvgPicture.asset(iconPath,
            colorFilter: ColorFilter.mode(
                fabController.iconColor.value, BlendMode.srcIn));
      }),
    );
  }
}
