import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/common_widgets/buttons/primary-button/rs_primarybutton.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/controllers/login_controller.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/forget_password/forget_password_options/foget_password_model_bottom_sheet.dart';
import 'package:sharingle_user_app/src/repository/controller/helper_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    // final _formKey = GlobalKey<FormState>();
    return Form(
        key: controller.loginFormKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: RsFormHeight - 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: Helper.validateEmail,
                controller: controller.email,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_rounded),
                  labelText: RsEmail,
                  hintText: RsEmail,
                ),
              ),
              const SizedBox(height: RsFormHeight - 20.0),
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  obscureText: controller.showPassword.value ? false : true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    labelText: RsPassword,
                    hintText: RsPassword,
                    suffixIcon: IconButton(
                      onPressed: () => controller.showPassword.value =
                          !controller.showPassword.value,
                      icon: controller.showPassword.value
                          ? Icon(LineAwesomeIcons.eye)
                          : Icon(LineAwesomeIcons.eye_slash),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ForgetPasswordScreen.buildShowModalBottomSheet(context);
                  },
                  child: Text(RsForgetPassword),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RsPrimaryButton(
                  isLoading: controller.isLoading.value ? true : false,
                  text: RsLogin.tr.toUpperCase(),
                  onPress: controller.isFacebookLoading.value ||
                          controller.isGoogleLoading.value
                      ? () {}
                      : controller.isLoading.value
                          ? () {}
                          : () => controller.login(),
                ),
              ),
            ],
          ),
        ));
  }
}
