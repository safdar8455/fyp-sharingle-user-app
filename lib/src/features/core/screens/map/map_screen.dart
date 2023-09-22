import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/map/widgets/map_bottom_dragablesheet.dart';
import 'package:sharingle_user_app/src/features/core/screens/map/widgets/map_topbar_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapScreenController());
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            final CameraPosition cameraPosition =
                mapController.initialCameraPosition.value;
            return Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: size.height * 0.18,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: cameraPosition,
                onMapCreated: mapController.onMapCreated,
                compassEnabled: true,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                padding:
                    EdgeInsets.only(top: 120, right: 10, left: 10, bottom: 50),
              ),
            );
          }),
          MapScreenTopBar(),
          BottomDraggableSheet(),
        ],
      ),
    );
  }
}
