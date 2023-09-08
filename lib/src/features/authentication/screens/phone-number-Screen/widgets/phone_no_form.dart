import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sharingle_user_app/src/common_widgets/buttons/primary-button/rs_primarybutton.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/controllers/phone_controller.dart';

class PhoneNoFormWidget extends StatelessWidget {
  const PhoneNoFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneLinkController());
    var phoneNo;
    return Container(
      padding: EdgeInsets.symmetric(vertical: RsFormHeight - 10),
      child: Form(
        key: controller.phoneFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntlPhoneField(
              decoration: const InputDecoration(
                label: const Text(RsPhoneNo),
              ),
              showCountryFlag: false,
              initialCountryCode: 'PK',
              onChanged: (phone) {
                phoneNo = phone.completeNumber;
              },
            ),
            SizedBox(height: RsFormHeight - 20),
            Obx(() => RsPrimaryButton(
                  isLoading: controller.isLoading.value ? true : false,
                  text: RsContinue.tr,
                  onPress: controller.isFacebookLoading.value ||
                          controller.isGoogleLoading.value
                      ? () {}
                      : controller.isLoading.value
                          ? () {}
                          : () => controller.phoneAuthentication(phoneNo),
                )),
          ],
        ),
      ),
    );
  }
}
