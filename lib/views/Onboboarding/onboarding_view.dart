import 'package:flutter/material.dart';
import 'package:on_bording/core/Components/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Login_signup/login_screen.dart';
import 'onboarding_items.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Skip Button
                    TextButton(
                        onPressed: () => pageController
                            .jumpToPage(controller.items.length - 1),
                        child: Text("Skip",
                            style: TextStyle(color: Color(0xFF388175)))),

                    //Next Button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: primaryColor,
                      ),
                      width: 120,
                      height: 48,
                      child: TextButton(
                          onPressed: () => pageController.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeIn),
                          child: const Text("Next",
                              style: TextStyle(color: Color(0xFFffffff)))),
                    ),
                  ],
                ),
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Expanded(
              flex: 8,
              child: PageView.builder(
                  onPageChanged: (index) => setState(
                      () => isLastPage = controller.items.length - 1 == index),
                  itemCount: controller.items.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            fit: FlexFit.loose,
                            child: Image.asset(
                              controller.items[index].image,
                            )),
                        const SizedBox(height: 15),
                        Text(
                          controller.items[index].title,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Text(controller.items[index].descriptions,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                            textAlign: TextAlign.center),
                      ],
                    );
                  }),
            ),
            Expanded(
              flex: 5,
              child: //Indicator
                  SmoothPageIndicator(
                controller: pageController,
                count: controller.items.length,
                onDotClicked: (index) => pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeIn),
                effect: const WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  //Now the problem is when press get started button
  // after re run the app we see again the onboarding screen
  // so lets do one time onboarding

  //Get started button

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: primaryColor),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
          onPressed: () async {
            final pres = await SharedPreferences.getInstance();
            pres.setBool("onboarding", true);

            //After we press get started button this onboarding value become true
            // same key
            if (!mounted) return;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: const Text(
            "Start!",
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
