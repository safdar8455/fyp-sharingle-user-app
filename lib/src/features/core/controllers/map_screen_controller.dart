import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sharingle_user_app/src/features/core/controllers/location-Assestent/method_request.dart';

class MapScreenController extends GetxController {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  RxString darkMapTheme = "".obs;
  final RxDouble sheetPosition = 0.25.obs;
  final RxBool isExpanded = false.obs;

  // Test if location services are enabled.
  final RxBool serviceEnabled = false.obs;
  final initialCameraPosition = _kGooglePlex.obs;

  @override
  void onInit() async {
    serviceEnabled.value = await Geolocator.isLocationServiceEnabled();

    DefaultAssetBundle.of(Get.context!)
        .loadString("assets/map-theme/dark_map.json")
        .then((value) {
      darkMapTheme.value = Get.isDarkMode ? value : "[]";
    });

    super.onInit();
  }

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

  Future<void> onMapCreated(GoogleMapController controller) async {
    if (!_controller.isCompleted) {
      controller.setMapStyle(darkMapTheme.value);
      _controller.complete(controller);

      final CameraPosition? position = await determinePosition();
      controller.animateCamera(CameraUpdate.newCameraPosition(position!));
    }
    controller.setMapStyle(darkMapTheme.value);
    final CameraPosition? position = await determinePosition();
    controller.animateCamera(CameraUpdate.newCameraPosition(position!));
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      bool? openAppSettings = await Get.defaultDialog<bool?>(
        title: "Location Permissions Denied",
        middleText:
            "Location permissions are permanently denied. To enable location, please open app settings and grant location access.",
        textConfirm: "Open Settings",
        barrierDismissible: false,
      );

      if (openAppSettings == true) {
        await Geolocator.openAppSettings();
      }
    }
  }

  Future<CameraPosition?> determinePosition() async {
    try {
      serviceEnabled.value = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled.value) {
        final Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        String address = await MethodRequest.methodRequestCoordinated(
            Get.context!, position);
        print("Your Address is :: " + address);
        LatLng latLng = LatLng(position.latitude, position.longitude);
        CameraPosition currentPosition =
            CameraPosition(target: latLng, zoom: 5.4746);
        return currentPosition;
      } else {
        final Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        String address = await MethodRequest.methodRequestCoordinated(
            Get.context!, position);
        print("Your Address is :: " + address);
        LatLng latLng = LatLng(position.latitude, position.longitude);
        CameraPosition currentPosition =
            CameraPosition(target: latLng, zoom: 16.4746);
        return currentPosition;
      }
    } catch (e) {
      print("Error getting current position: $e");
      return null;
    }
  }
}
