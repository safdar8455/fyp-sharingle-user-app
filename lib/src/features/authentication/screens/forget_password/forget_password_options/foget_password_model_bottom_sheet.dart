import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';

class ForgetPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(RsDefaultSize),
        topRight: Radius.circular(RsDefaultSize),
      )),
      builder: (context) => Container(
        padding: const EdgeInsets.all(RsDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              RsForgetPasswordTitle,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              RsForgetPasswordSubTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: RsDefaultSize - 10.0),
            ForgetPoasswordButtonWidget(
              btnIcon: Icons.mail_outline_rounded,
              title: RsEmail,
              subTitle: RsResetViaEmail,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const ForgetPasswordMailScreen());
              },
            ),
            SizedBox(height: RsDefaultSize - 10.0),
          ],
        ),
      ),
    );
  }
}
