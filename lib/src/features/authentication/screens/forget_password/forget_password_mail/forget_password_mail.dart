import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/common_widgets/buttons/primary-button/rs_primarybutton.dart';
import 'package:sharingle_user_app/src/common_widgets/form/form_header_widget.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/controllers/login_controller.dart';
import 'package:sharingle_user_app/src/repository/controller/helper_controller.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(RsDefaultSize),
            child: Column(
              children: [
                SizedBox(height: RsDefaultSize),
                FormHeaderWidget(
                  applogoImage: isDarkMode ? RsAppLogoDark : RsAppLogoLight,
                  image: isDarkMode
                      ? RsForgetPasswordImageDark
                      : RsForgetPasswordImageLight,
                  title: RsForgetPassword,
                  subTitle: RsForgetEmailSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBeteen: RsDefaultSize,
                  imageHeight: 0.3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: RsFormHeight),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.email,
                        validator: Helper.validateEmail,
                        decoration: const InputDecoration(
                          label: Text(RsEmail),
                          hintText: RsEmail,
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: RsPrimaryButton(
                          isLoading: controller.isLoading.value ? true : false,
                          text: RsNext.tr.toUpperCase(),
                          onPress: controller.isFacebookLoading.value ||
                                  controller.isGoogleLoading.value
                              ? () {}
                              : controller.isLoading.value
                                  ? () {}
                                  : () => controller.ResetEmail(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
