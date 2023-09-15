import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/map/widgets/map_topbar_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapScreenController());
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    // final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0xFFE5E5E5),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Obx(() {
              final CameraPosition cameraPosition =
                  mapController.cameraPosition.value;
              return Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: size.height * 0.1, // Adjust bottom height as needed
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: cameraPosition,
                  onMapCreated: mapController.onMapCreated,
                ),
              );
            }),
            MapScreenTopBar(),
          ],
        ),
      ),
    );
  }
}
