import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/common_widgets/buttons/social-button/facebook_button.dart';
import 'package:sharingle_user_app/src/common_widgets/buttons/social-button/google_button.dart';
import 'package:sharingle_user_app/src/features/authentication/controllers/login_controller.dart';

class SocialFooter extends StatelessWidget {
  const SocialFooter({
    Key? key,
    required this.footerLineOnPress,
    required this.footerLineText1,
    required this.footerLineText2,
  }) : super(key: key);

  final VoidCallback footerLineOnPress;
  final String footerLineText1;
  final String footerLineText2;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => RsGoogleButton(
                    isLoading: controller.isGoogleLoading.value ? true : false,
                    onPress: controller.isFacebookLoading.value ||
                            controller.isLoading.value
                        ? () {}
                        : controller.isGoogleLoading.value
                            ? () {}
                            : () => controller.googleSignIn(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(
                  () => RsFacebookButton(
                    isLoading:
                        controller.isFacebookLoading.value ? true : false,
                    onPress: controller.isGoogleLoading.value ||
                            controller.isLoading.value
                        ? () {}
                        : controller.isFacebookLoading.value
                            ? () {}
                            : () => controller.facebookSignIn(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          TextButton(
              onPressed: footerLineOnPress,
              child: Text.rich(TextSpan(
                  text: footerLineText1,
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    TextSpan(
                      text: " ${footerLineText2.toLowerCase()}",
                      style: TextStyle(color: Colors.blue),
                    )
                  ]))),
        ],
      ),
    );
  }
}
