import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../Donate/Donate section.dart';
import '../Home/home.dart';
import '../Individuals/individuals_screen.dart';
import '../Settings/main_settings_screen.dart';
import 'ButtonNavBarIcon.dart';
import 'custom_floating_action_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageStorageBucket pageStorage = PageStorageBucket();
  Widget currentPage = Home();
  int selectTap = 0;

  @override
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          PageStorage(bucket: pageStorage, child: currentPage),
          SafeArea(
              child: Column(
            children: [const Spacer(), buildCustomNavBar(media)],
          ))
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CustomFloatingActionButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  buildCustomNavBar(Size media) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
        ),
        child: Stack(alignment: Alignment.center, children: [
          Container(
            width: media.width,
            height: 75,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/Subtract.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  // More subtle black shadow
                  spreadRadius: 0,
                  blurRadius: 4,
                  // Reduced blur radius
                  offset: const Offset(0, 0), // Smaller offset for the shadow
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  // More subtle white "shadow"
                  spreadRadius: 0,
                  blurRadius: 4,
                  // Reduced blur radius
                  offset: const Offset(0, -2), // Smaller offset for the "light"
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonNavBarIcon(
                size: 24,
                data: 'assets/images/home.svg',
                onTap: () {
                  setState(() {
                    selectTap = 0;
                    currentPage = Home();
                  });
                },
                color: selectTap == 0
                    ? const Color(0xff388175)
                    : const Color(0xffBFBFBF),
              ),
              ButtonNavBarIcon(
                size: 24,
                data: 'assets/images/mdi_donation-outline.svg',
                onTap: () {
                  setState(() {
                    selectTap = 1;
                    currentPage = DonateSection();
                  });
                },
                color: selectTap == 1
                    ? const Color(0xff388175)
                    : const Color(0xffBFBFBF),
              ),
              const Gap(50),
              ButtonNavBarIcon(
                size: 24,
                data: 'assets/images/Vector.svg',
                onTap: () {
                  setState(() {
                    selectTap = 2;
                    currentPage = IndividualsScreen();
                  });
                },
                color: selectTap == 2
                    ? const Color(0xff388175)
                    : const Color(0xffBFBFBF),
              ),
              ButtonNavBarIcon(
                size: 24,
                data: 'assets/images/settings.svg',
                onTap: () {
                  setState(() {
                    selectTap = 3;
                    currentPage = MainSettingsScreen();
                  });
                },
                color: selectTap == 3
                    ? const Color(0xff388175)
                    : const Color(0xffBFBFBF),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
