import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sharingle_user_app/src/features/core/controllers/location-Assestent/method_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final Rx<LatLng?> initialPickupLatLng = LatLng(0, 0).obs;

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

  Future<void> saveLatLngToSharedPreferences(LatLng latLng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', latLng.latitude);
    await prefs.setDouble('longitude', latLng.longitude);
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

  // Callback when the Google Map is Idle
  Future<void> onCameraIdle() async {
    CameraPosition? dPosition = destinationPosition.value;
    CameraPosition? cPosition = currentPosition.value;
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

      bool isCurrentLocation = (dPosition.target.latitude.toStringAsFixed(5)) ==
          (cPosition!.target.latitude.toStringAsFixed(5));

      if (!(dPosition.target.latitude == 0) &&
          !(dPosition.target.longitude == 0) &&
          !isCurrentLocation) {
        isCameraMoving.value = "false";
        isDestinationSelectedPointer.value = true;

        String address =
            await MethodRequest.methodRequestCoordinated(Get.context!, posit);
        destinationAddress.value = address;
      } else {
        isCameraMoving.value = "";
      }

      // print("Latitude: ${dPosition.target.latitude.toStringAsFixed(5)}");
      // print("Latitude: ${cPosition.target.latitude.toStringAsFixed(5)}");
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

    if (initialPickupLatLng.value != LatLng(0, 0)) {
      // Set a custom default location if determining the position fails
      final InitialPickupPosition = CameraPosition(
        target: initialPickupLatLng.value!, // Karachi coordinates
        zoom: 18.0,
      );
      destinationPosition.value = InitialPickupPosition;
      currentPosition.value = InitialPickupPosition;

      controller
          .animateCamera(CameraUpdate.newCameraPosition(InitialPickupPosition));
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
          zoom: 12.0,
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
        await Geolocator.isLocationServiceEnabled().whenComplete(() async =>
            serviceEnabled.value = await Geolocator.isLocationServiceEnabled());
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // String address =
      //     await MethodRequest.methodRequestCoordinated(Get.context!, position);
      // print("Your Address is :: " + address);

      double zoomLevel = serviceEnabled.value ? 18.4746 : 5.4746;
      LatLng latLng = LatLng(position.latitude, position.longitude);

      // Save the LatLng value in SharedPreferences
      await saveLatLngToSharedPreferences(latLng);
      CameraPosition currentPosition =
          CameraPosition(target: latLng, zoom: zoomLevel);

      return currentPosition;
    } catch (e) {
      print("Error getting current position: $e");
      return null;
    }
  }

  
}
