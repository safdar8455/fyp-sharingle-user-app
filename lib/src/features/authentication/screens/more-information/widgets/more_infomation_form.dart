import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/common_widgets/buttons/primary-button/rs_primarybutton.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/controllers/more_info_controller.dart';

class MoreInfoFormWidget extends StatelessWidget {
  const MoreInfoFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoreInfoController());
    return Container(
      padding: EdgeInsets.symmetric(vertical: RsFormHeight - 10),
      child: Form(
        key: controller.moreInfoKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: RsFormHeight - 20),
            TextFormField(
              controller: controller.fullName,
              decoration: const InputDecoration(
                  label: const Text(RsFullName),
                  prefixIcon: Icon(LineAwesomeIcons.user_circle)),
            ),
            SizedBox(height: RsFormHeight - 20),
            DropdownButtonFormField<String>(
              value: controller.selectedGender.value,
              items: controller.genderOptions
                  .map((gender) => DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (newValue) {
                controller.selectedGender.value = newValue ?? "Gender";
              },
              decoration: InputDecoration(
                labelText: "Gender",
                prefixIcon: Icon(
                    LineAwesomeIcons.venus_mars), // You can replace this icon
              ),
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
                          : () => controller.submitInformation(),
                )),
          ],
        ),
      ),
    );
  }
}
