import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:sharingle_user_app/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:sharingle_user_app/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/login/login_screen.dart';

class WelocmeScreen extends StatelessWidget {
  const WelocmeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    var size = mediaQuery.size;

    final controller = Get.put(FadeAnimationController());
    controller.startAnimation();

    return Scaffold(
      body: Stack(
        children: [
          RsFadeInAnimation(
            durationInMs: 1200,
            animatePosition: RsAnimatePosition(
              bottomAfter: 0,
              bottomBefore: -100,
              topAfter: 0,
              topBefore: 0,
              leftAfter: 0,
              leftBefore: 0,
              rightAfter: 0,
              rightBefore: 0,
            ),
            child: Container(
              padding: EdgeInsets.all(RsDefaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: size.height * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: isDarkMode
                              ? AssetImage(RsWelcomeDarkScreenImage)
                              : AssetImage(RsWelcomeLightScreenImage),
                        ),
                        SizedBox(height: RsDefaultSize),
                        Image(
                          image: isDarkMode
                              ? AssetImage(RsAppLogoDark)
                              : AssetImage(RsAppLogoLight),
                          height: size.height * 0.03,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        RsWelcomeTitle,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        RsWelcomeSubTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.offAll(() => const LoginScreen()),
                      child: Text("getstarted".toUpperCase()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
