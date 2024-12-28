import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/HomeController.dart';
import 'package:on_bording/controller/login_controller.dart';
import 'package:on_bording/views/Settings/settings_screen.dart';

import '../wallet/wallet_screen.dart';
import 'edit_profile_screen.dart'; // For Cupertino widgets

class MainSettingsScreen extends StatelessWidget {
  MainSettingsScreen({super.key});

  final LoginController controller = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 24), // Global padding for left and right
        child: ListView(
          children: [
            Column(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: homeController.userModel.value.imageUrl,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                const SizedBox(height: 24),
                // Spacing after the avatar
                // A method to build each ListTile with Divider
                _buildListItem(
                  onTap: () {
                    Get.to(() => EditProfileScreen());
                  },
                  icon: 'assets/images/profile.svg',
                  title: 'Edit Profile',
                  context: context,
                ),
                _buildListItem(
                  onTap: () {
                    Get.to(() => const WalletScreen());
                  },
                  icon: 'assets/images/wallet.svg',
                  title: 'Wallet',
                  context: context,
                ),
                _buildListItem(
                  onTap: () {
                    Get.to(() => const SettingsScreen());
                  },
                  icon: 'assets/images/settings.svg',
                  title: 'Settings',
                  context: context,
                ),
                // SwitchListTile(
                //   activeColor: const Color(0xFF388175),
                //   secondary: SvgPicture.asset('assets/images/notification.svg'),
                //   title: const Text('Notifications'),
                //   value: true,
                //   onChanged: (bool value) {
                //     Get.to(() => NotfiScreen());
                //   },
                // ),
                // const Divider(),
                // SwitchListTile(
                //   activeColor: const Color(0xFF388175),
                //   secondary: SvgPicture.asset('assets/images/Moon.svg'),
                //   title: const Text('Dark Mode'),
                //   value: false,
                //   onChanged: (bool value) {
                //     // Handle dark mode switch toggle
                //   },
                // ),
                const Divider(),
                ListTile(
                  leading: SvgPicture.asset('assets/images/Logout.svg'),
                  title: const Text('Log Out',
                      style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    controller.logout();
                  },
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
      {required VoidCallback onTap,
      required String icon,
      required String title,
      required BuildContext context}) {
    return Column(
      children: [
        ListTile(
          leading: SvgPicture.asset(icon),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
