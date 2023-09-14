import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenController extends GetxController {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    target: LatLng(24.923410791271117, 67.14917708830312),
    zoom: 14.4746,

    // tilt: 59.440717697143555,
    // zoom: 19.151926040649414,
  );

  final cameraPosition = _kGooglePlex.obs;

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
  }

  Future<void> goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
