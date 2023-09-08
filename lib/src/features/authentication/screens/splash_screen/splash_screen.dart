import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:sharingle_user_app/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;

    final controller = Get.put(FadeAnimationController());

    controller.startSplashAnimation();
    return Scaffold(
      body: Stack(
        children: [
          RsFadeInAnimation(
            durationInMs: 1600,
            animatePosition: RsAnimatePosition(
              topAfter: 0,
              topBefore: -30,
              leftAfter: 0,
              leftBefore: -30,
              height: 80,
            ),
            child: Image(
              image: isDarkMode
                  ? AssetImage(RsSplashTopIconDark)
                  : AssetImage(RsSplashTopIconLight),
            ),
          ),
          RsFadeInAnimation(
            durationInMs: 2000,
            animatePosition: RsAnimatePosition(
              topAfter: 85,
              topBefore: 85,
              leftAfter: RsDefaultSize,
              leftBefore: -85,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  RsAppName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  RsAppTagLine,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
          RsFadeInAnimation(
            durationInMs: 2400,
            animatePosition: RsAnimatePosition(
              bottomBefore: 0,
              bottomAfter: 150,
              leftAfter: RsDefaultSize,
              leftBefore: RsDefaultSize,
              rightAfter: RsDefaultSize,
              rightBefore: RsDefaultSize,
            ),
            child: Image(
              image: isDarkMode
                  ? AssetImage(RsSplashDarkImage)
                  : AssetImage(RsSplashLightImage),
              height: size.height * 0.4,
            ),
          ),
          RsFadeInAnimation(
            durationInMs: 2400,
            animatePosition: RsAnimatePosition(
              bottomAfter: 60,
              bottomBefore: 0,
              rightAfter: RsDefaultSize,
              rightBefore: RsDefaultSize,
            ),
            child: Container(
                width: RsSplashContainerSize,
                height: RsSplashContainerSize,
                decoration: BoxDecoration(
                  color: isDarkMode ? secondaryColor : primaryColor,
                  borderRadius: BorderRadius.circular(100),
                )),
          ),
        ],
      ),
    );
  }
}
