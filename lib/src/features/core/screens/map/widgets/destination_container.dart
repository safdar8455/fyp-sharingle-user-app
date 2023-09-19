import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';

class DestinationContainer extends StatelessWidget {
  const DestinationContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapScreenController());
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    final size = mediaQuery.size;
    return SafeArea(
      child: Container(
        height: size.height * 0.95,
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: RsDefaultSize,
        ),
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xFF303030) : RsWhiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    mapController.toggleSheetExpansion();
                  },
                  child: Icon(LineAwesomeIcons.arrow_down),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(5),
                    shape: CircleBorder(),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(LineAwesomeIcons.calendar),
                      SizedBox(width: 5),
                      Text("Now"),
                      SizedBox(width: 5),
                      Icon(LineAwesomeIcons.arrow_down),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your destination",
                prefixIcon: Icon(LineAwesomeIcons.search),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
