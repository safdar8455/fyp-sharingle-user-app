import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenController extends GetxController {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  RxString darkMapTheme = "".obs;
  final RxDouble sheetPosition = 0.25.obs;
  final RxBool isExpanded = false.obs;

  // Test if location services are enabled.
  final RxBool serviceEnabled = false.obs;
  final Rx<CameraPosition?> destinationPosition =
      CameraPosition(target: LatLng(0, 0), zoom: 12.0).obs;
  final Rx<CameraPosition?> currentPosition =
      CameraPosition(target: LatLng(0, 0), zoom: 12.0).obs;

  // Add a flag to track whether the camera is moving
  final RxString isCameraMoving = "".obs;
  final RxString destinationAddress = "".obs;
  final RxBool isDestinationSelectedPointer = false.obs;
  final RxBool isDestinationSelected = false.obs;

  @override
  void onInit() async {
    // Check if location services are enabled
    serviceEnabled.value = await Geolocator.isLocationServiceEnabled();

    // isDestinationSelectedPointer.value = false;

    // Load the map theme based on dark mode
    DefaultAssetBundle.of(Get.context!)
        .loadString("assets/map-theme/dark_map.json")
        .then((value) {
      darkMapTheme.value = Get.isDarkMode ? value : "[]";
    });

    super.onInit();
  }

  // Toggle the bottom sheet expansion
  void toggleSheetExpansion() {
    isExpanded.value = !isExpanded.value;
    if (isExpanded.value) {
      sheetPosition.value = 1.0; // Fully expand the sheet
    } else {
      sheetPosition.value = isDestinationSelectedPointer.value ? 0.3 : 0.25;
    }
  }

  // Callback when the Google Map is created
  Future<void> onMapCreated(GoogleMapController controller) async {
    final currentLocation = await Geolocator.isLocationServiceEnabled();
    isDestinationSelectedPointer.value = false;
    controller.setMapStyle(darkMapTheme.value);
    isCameraMoving.value = "";

    destinationPosition.value =
        CameraPosition(target: LatLng(0, 0), zoom: 12.0);

    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }

    if (currentLocation) {
      final initialPosition = await determinePosition();
      if (initialPosition != null) {
        destinationPosition.value = initialPosition;
        currentPosition.value = initialPosition;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(initialPosition));
      } else {
        // Set a custom default location if determining the position fails
        final customDefaultPosition = CameraPosition(
          target: LatLng(24.8607, 67.0011), // Karachi coordinates
          zoom: 12.0, // Adjust the zoom level as needed
        );
        destinationPosition.value = customDefaultPosition;
        controller.animateCamera(
            CameraUpdate.newCameraPosition(customDefaultPosition));
      }
    }
  }

  // Check and request location permission if needed
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

  // Determine the initial camera position based on location service status
  Future<CameraPosition?> determinePosition() async {
    try {
      if (!(serviceEnabled.value)) {
        await Geolocator.isLocationServiceEnabled()
            .whenComplete(() => serviceEnabled.value = true);
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // String address =
      //     await MethodRequest.methodRequestCoordinated(Get.context!, position);
      // print("Your Address is :: " + address);

      double zoomLevel = serviceEnabled.value ? 18.4746 : 5.4746;
      LatLng latLng = LatLng(position.latitude, position.longitude);
      CameraPosition currentPosition =
          CameraPosition(target: latLng, zoom: zoomLevel);

      return currentPosition;
    } catch (e) {
      print("Error getting current position: $e");
      return null;
    }
  }
}
