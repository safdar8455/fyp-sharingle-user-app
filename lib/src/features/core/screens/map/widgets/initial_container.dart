// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';
import 'package:sharingle_user_app/src/features/core/models/search-destination/select_destination_onmap.dart';

class InitialContainer extends StatelessWidget {
  const InitialContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapScreenController());
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    final size = mediaQuery.size;
    return Container(
      height: size.height * 1,
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
          Container(
            height: 5,
            width: 80,
            decoration: BoxDecoration(
              color: isDarkMode ? RsWhiteColor : Color(0xFF272727),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Where to? ",
                style: Theme.of(context).textTheme.displayMedium,
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
          Obx(() {
            return mapController.isDestinationSelectedPointer.value
                ? SelectedDestinationAddress()
                : SelectDestinationBox();
          }),
        ],
      ),
    );
  }
}

class SelectedDestinationAddress extends StatelessWidget {
  const SelectedDestinationAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapScreenController());
    return Obx(() {
      SelectDestinationOnMap destinationOnMap =
          mapController.destinationDetailList[0];

      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.location_on),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Near ${destinationOnMap.placeName}",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 5),
                      Text(
                        destinationOnMap.placeAddress!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                    onPressed: () {
                      mapController.saveLocation(destinationOnMap.placeId!);
                    },
                    icon: Icon(LineAwesomeIcons.heart)),
              ],
            ),
            SizedBox(height: 20),

            // Confirm dropoff button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(RsConfirmdropoff),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class SelectDestinationBox extends StatelessWidget {
  const SelectDestinationBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapScreenController());
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Color(0xFF303030)
            : Colors.grey.shade400.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 0.1,
            offset: Offset(0, 1),
            color: isDarkMode
                ? RsWhiteColor.withOpacity(0.1)
                : RsDarkColor.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              mapController.toggleSheetExpansion();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  LineAwesomeIcons.search,
                  color: isDarkMode ? Colors.grey.shade300 : Colors.black54,
                ),
                SizedBox(width: 10),
                Text(RsEnterYourDestionation,
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Skip",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
