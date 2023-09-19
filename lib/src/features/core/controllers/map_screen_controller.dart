import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenController extends GetxController {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  RxString darkMapTheme = "".obs;
  final RxDouble sheetPosition = 0.25.obs;
  final RxBool isExpanded = false.obs;

  void toggleSheetExpansion() {
    isExpanded.value = !isExpanded.value;
    if (isExpanded.value) {
      sheetPosition.value = 1.0; // Fully expand the sheet
    } else {
      sheetPosition.value = 0.25; // Set it back to the initial position
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 11.4746,
  );

  final cameraPosition = _kGooglePlex.obs;

  Future<void> onMapCreated(GoogleMapController controller) async {
    if (!_controller.isCompleted) {
      controller.setMapStyle(darkMapTheme.value);
      _controller.complete(controller);
    }
  }
}
