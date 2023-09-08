import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/common_widgets/buttons/primary-button/rs_primarybutton.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/controllers/signup_controller.dart';
import 'package:sharingle_user_app/src/repository/controller/helper_controller.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Container(
      padding: EdgeInsets.symmetric(vertical: RsFormHeight - 10),
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: RsFormHeight - 20),
            TextFormField(
              controller: controller.email,
              validator: Helper.validateEmail,
              decoration: const InputDecoration(
                  label: const Text(RsEmail),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  )),
            ),
            SizedBox(height: RsFormHeight - 20),
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: Helper.validatePassword,
                obscuringCharacter: '*',
                obscureText: controller.showPassword.value ? false : true,
                decoration: InputDecoration(
                  label: const Text(RsPassword),
                  prefixIcon: Icon(
                    Icons.fingerprint,
                  ),
                  suffixIcon: IconButton(
                      icon: controller.showPassword.value
                          ? Icon(LineAwesomeIcons.eye)
                          : Icon(LineAwesomeIcons.eye_slash),
                      onPressed: () => controller.showPassword.value =
                          !(controller.showPassword.value)),
                ),
              ),
            ),
            SizedBox(height: RsFormHeight - 20),
            Obx(() => RsPrimaryButton(
                  isLoading: controller.isLoading.value ? true : false,
                  text: RsSignup.tr,
                  onPress: controller.isFacebookLoading.value ||
                          controller.isGoogleLoading.value
                      ? () {}
                      : controller.isLoading.value
                          ? () {}
                          : () => controller.createUser(),
                )),
          ],
        ),
      ),
    );
  }
}
