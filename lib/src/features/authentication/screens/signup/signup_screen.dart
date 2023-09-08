import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/common_widgets/footer/social_footer.dart';
import 'package:sharingle_user_app/src/common_widgets/form/form_header_widget.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/login/login_screen.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(RsDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHeaderWidget(
                  applogoImage: isDarkMode ? RsAppLogoDark : RsAppLogoLight,
                  image: isDarkMode
                      ? RsWelcomeDarkScreenImage
                      : RsWelcomeLightScreenImage,
                  title: RsSignUpTitle,
                  subTitle: RsSignUpSubTitle,
                ),
                SignUpFormWidget(),
                SocialFooter(
                    footerLineOnPress: () {
                      Get.offAll(() => LoginScreen());
                    },
                    footerLineText1: RsAlreadyHaveAnAccount,
                    footerLineText2: RsLogin),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
