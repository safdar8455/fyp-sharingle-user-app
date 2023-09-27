import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/features/core/controllers/location-Assestent/method_request.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/map/widgets/map_bottom_dragablesheet.dart';
import 'package:sharingle_user_app/src/features/core/screens/map/widgets/map_topbar_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapScreenController());
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    final size = mediaQuery.size;

    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: size.height * 0.2,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(24.8607, 67.0011),
                  zoom: 11.4746,
                ),
                onMapCreated: mapController.onMapCreated,
                compassEnabled: true,
                myLocationEnabled:
                    !(mapController.isCameraMoving.value == "true"),
                onCameraMove: (position) {
                  mapController.isCameraMoving.value = "true";
                  if (mapController.currentPosition.value != position) {
                    mapController.destinationPosition.value = position;
                  }
                },
                onCameraIdle: () async {
                  CameraPosition? dPosition =
                      mapController.destinationPosition.value;
                  CameraPosition? cPosition =
                      mapController.currentPosition.value;
                  if (dPosition != null) {
                    Position posit = Position(
                      latitude: dPosition.target.latitude,
                      longitude: dPosition.target.longitude,
                      speedAccuracy: 0.0,
                      timestamp: DateTime.now(),
                      accuracy: 1,
                      altitude: 0.0,
                      heading: 0.0,
                      speed: 0.0,
                    );

                    bool isCurrentLocation =
                        (dPosition.target.latitude.toStringAsFixed(5)) ==
                            (cPosition!.target.latitude.toStringAsFixed(5));

                    if (!(dPosition.target.latitude == 0) &&
                        !(dPosition.target.longitude == 0) &&
                        !isCurrentLocation) {
                      mapController.isCameraMoving.value = "false";
                      mapController.isDestinationSelectedPointer.value = true;

                      String address =
                          await MethodRequest.methodRequestCoordinated(
                              context, posit);
                      mapController.destinationAddress.value = address;
                    } else {
                      mapController.isCameraMoving.value = "";
                    }

                    print(
                        "Latitude: ${dPosition.target.latitude.toStringAsFixed(5)}");
                    print(
                        "Latitude: ${cPosition.target.latitude.toStringAsFixed(5)}");
                  }
                },
                zoomControlsEnabled: false,
                padding:
                    EdgeInsets.only(top: 120, right: 10, left: 10, bottom: 50),
              ),
            );
          }),

          // Position Marker set on Map
          Obx(() {
            if (mapController.isCameraMoving.value == "true") {
              return Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: size.height * 0.12,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 5,
                    height: 5,
                    child: Image(
                      image: isDarkMode
                          ? AssetImage(RsMovingDarkMarker)
                          : AssetImage(RsMovingLightMarker),
                    ),
                  ),
                ),
              );
            } else if (mapController.isCameraMoving.value == "false") {
              return Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: size.height * 0.15,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Image(
                      image: isDarkMode
                          ? AssetImage(RsDestinationLightMarker)
                          : AssetImage(RsDestinationDarkMarker),
                    ),
                  ),
                ),
              );
            } else if (mapController.isCameraMoving.value == "") {
              return SizedBox(); // Return an empty SizedBox for other cases
            } else {
              return SizedBox();
            }
          }),
          MapScreenTopBar(),
          BottomDraggableSheet(),
        ],
      ),
    );
  }
}
