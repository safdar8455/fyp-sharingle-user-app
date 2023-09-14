import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapScreenController());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Obx(() {
              final CameraPosition cameraPosition =
                  mapController.cameraPosition.value;
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: cameraPosition,
                onMapCreated: mapController.onMapCreated,
              );
            }),
            Positioned(
              bottom: 16,
              left: 16,
              child: FloatingActionButton.extended(
                onPressed: () => mapController.goToTheLake(),
                label: const Text('To the lake!'),
                icon: const Icon(Icons.directions_boat),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
