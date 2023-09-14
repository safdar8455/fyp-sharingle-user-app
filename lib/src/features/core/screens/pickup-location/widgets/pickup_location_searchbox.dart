import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/features/core/screens/map/map_screen.dart';

class PickupSearchBox extends StatelessWidget {
  const PickupSearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Get.to(() => const MapScreen());
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? RsWhiteColor.withOpacity(0.1)
                  : RsDarkColor.withOpacity(0.1), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 20, // Blur radius
              offset: Offset(0, 2), // Offset in x and y
            ),
          ],
          color: isDarkMode ? Color(0xFF303030) : RsWhiteColor,
          border: Border.all(
            width: 1.0,
            color: isDarkMode
                ? RsWhiteColor.withOpacity(0.6)
                : RsDarkColor.withOpacity(0.6),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          children: [
            Icon(LineAwesomeIcons.dot_circle_1),
            SizedBox(width: 10),
            Text(
              "Enter your pickup locations...",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.apply(color: Colors.grey.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
