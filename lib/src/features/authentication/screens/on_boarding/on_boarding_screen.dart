import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/features/authentication/controllers/on_boarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final obController = OnBoardingController();
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        LiquidSwipe(
          pages: obController.pages,
          liquidController: obController.controller,
          onPageChangeCallback: obController.onPageChangeCallback,
          slideIconWidget: const Icon(Icons.arrow_back_ios),
          enableSideReveal: true,
        ),
        Positioned(
            bottom: 60.0,
            child: OutlinedButton(
                onPressed: () => obController.animateToNextSlide(),
                style: ElevatedButton.styleFrom(
                  side: isDarkMode
                      ? BorderSide(color: secondaryColor)
                      : BorderSide(color: primaryColor),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  foregroundColor: isDarkMode ? secondaryColor : primaryColor,
                ),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: isDarkMode ? secondaryColor : primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: isDarkMode ? primaryColor : secondaryColor,
                  ),
                ))),
        Positioned(
            top: 50,
            right: 20,
            child: TextButton(
                onPressed: () => obController.skip(),
                child: Text(
                  "Skip",
                  style: isDarkMode
                      ? TextStyle(color: secondaryColor.withOpacity(0.8))
                      : TextStyle(color: primaryColor.withOpacity(0.8)),
                ))),
        Obx(
          () => Positioned(
              bottom: 30,
              child: AnimatedSmoothIndicator(
                activeIndex: obController.currentPage.value,
                count: 3,
                effect: WormEffect(
                  activeDotColor: isDarkMode ? secondaryColor : primaryColor,
                  dotHeight: 5.0,
                ),
              )),
        )
      ]),
    );
  }
}
