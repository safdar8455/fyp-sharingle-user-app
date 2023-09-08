import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/common_widgets/footer/social_footer.dart';
import 'package:sharingle_user_app/src/common_widgets/form/form_header_widget.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/login/widgets/login_form-widget.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                  title: RsLoginTitle,
                  subTitle: RsLoginSubTitle,
                ),
                LoginForm(),
                Row(children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text('OR', style: TextStyle(fontSize: 14)),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ]),
                SocialFooter(
                    footerLineOnPress: () {
                      Get.offAll(() => SignUpScreen());
                    },
                    footerLineText1: RsDontHaveAnAccount,
                    footerLineText2: RsSignup)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
