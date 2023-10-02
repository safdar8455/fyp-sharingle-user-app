import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/core/controllers/save_location_controller.dart';

class SaveLocationFrom extends StatelessWidget {
  const SaveLocationFrom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    final controller = Get.put(SaveLocationController());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Place Name TextFiled
            TextField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.isLocationNameEmpty.value = false;
                } else {
                  controller.isLocationNameEmpty.value = true;
                }
              },
              decoration: InputDecoration(
                hintText: RsNameYourLocation,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: isDarkMode ? Color(0xFFFAFAFA) : Color(0xFF303030),
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: isDarkMode ? Color(0xFF64B5F6) : Color(0xFF001BFF),
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            // Place Pickup Details
            Obx(() {
              return controller.isClickAddOtherDetail.value
                  ? TextField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          controller.isLocationNameEmpty.value = true;
                        } else {
                          controller.isLocationNameEmpty.value = false;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: RsAddPickupDetails,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 2,
                          color: isDarkMode
                              ? Color(0xFFFAFAFA)
                              : Color(0xFF303030),
                          style: BorderStyle.solid,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 2,
                          color: isDarkMode
                              ? Color(0xFF64B5F6)
                              : Color(0xFF001BFF),
                          style: BorderStyle.solid,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        )),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        controller.isClickAddOtherDetail.value = true;
                      },
                      child: Text(
                        RsAddOtherDetails.toUpperCase(),
                        style: TextStyle(
                          color: isDarkMode
                              ? Color(0xFFFAFAFA)
                              : Color(0xFF303030),
                        ),
                      ));
            }),
            SizedBox(height: RsDefaultSize),

            // Place Save Button
            Obx(() {
              return controller.isLocationNameEmpty.value
                  ? SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(RsSave),
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(RsSave),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                        ),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
