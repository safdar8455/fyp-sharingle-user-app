import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/map/map_screen.dart';
import 'package:sharingle_user_app/src/features/core/screens/pickup-location/pickup_location_screen.dart';

class DashboardSearchBox extends StatelessWidget {
  const DashboardSearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mapController = Get.put(MapScreenController());
    return GestureDetector(
      onTap: () {
        mapController.serviceEnabled.value
            ? Get.to(() => const MapScreen())
            : Get.to(() => const PickupLocationScreen());
      },
      child: Container(
        decoration:
            const BoxDecoration(border: Border(left: BorderSide(width: 4))),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(RsDashboardSearch,
                style: textTheme.displayLarge
                    ?.apply(color: Colors.grey.withOpacity(0.5))),
            const Icon(
              Icons.search_rounded,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
