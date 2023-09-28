import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
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
                hintText: RsEnterYourDestionation,
                prefixIcon: Icon(LineAwesomeIcons.search),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Icon(LineAwesomeIcons.search),
                  ),
                  SizedBox(height: 20),
                  Text(
                    RsFullSheetTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    RsFullSheetSubTitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(RsSelectLocationOnMap),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(RsSkipDestinationStep),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
