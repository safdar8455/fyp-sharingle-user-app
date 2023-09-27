import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/darshboard.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/widgets/profile-top-sheet/profile_topsheet.dart';

class MapScreenTopBar extends StatelessWidget {
  const MapScreenTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    final mapController = Get.put(MapScreenController());
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: size.height * 0.18,
        padding: EdgeInsets.only(
          top: 40,
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isDarkMode
                  ? Color(0xFF303030).withOpacity(0.95)
                  : Color(0xFFE5E5E5).withOpacity(0.95),
              isDarkMode
                  ? Color(0xFF272727).withOpacity(0.0)
                  : Color(0xFFE5E5E5).withOpacity(0.0),
            ],
            stops: [0.6, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    mapController.currentPosition.value =
                        CameraPosition(target: LatLng(0, 0), zoom: 12.0);
                    mapController.isCameraMoving.value = "";
                    Get.back();
                  },
                  child: Icon(LineAwesomeIcons.times),
                  style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(5.0),
                  ),
                ),
                Image(
                  image: isDarkMode
                      ? AssetImage(RsAppLogoDark)
                      : AssetImage(RsAppLogoLight),
                  height: size.height * 0.02,
                ),
                OutlinedButton(
                  onPressed: () {
                    ProfileTopSheet(
                            onPressHome: () =>
                                Get.to(() => const DashboardScreen()))
                        .profileTopSheet(context);
                  },
                  child: Icon(Icons.menu),
                  style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(5.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
