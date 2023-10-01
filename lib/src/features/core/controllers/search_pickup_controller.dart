import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/core/controllers/location-Assestent/request_location.dart';
import 'package:sharingle_user_app/src/features/core/models/search-pickup/nearbylocationjson.dart';
import 'package:sharingle_user_app/src/features/core/models/search-pickup/pickup_address.dart';
import 'package:sharingle_user_app/src/features/core/models/search-pickup/placesjson.dart';

class SearchPickupController extends GetxController {
  static SearchPickupController get instance => Get.find();

  @override
  void onInit() async {
    await nearbySearch();
    super.onInit();
  }

  RxList pickupPlaceList = [].obs;
  RxList nearbyLocationList = [].obs;
  RxBool isRecordNotFound = false.obs;
  RxBool isSearhFieldEmply = true.obs;

  Future<void> autoComplete(String placeAddress) async {
    if (placeAddress.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/textsearch/json?query=${placeAddress}&t&key=${GoogleMapAPIKey}&components=country:pk";
      try {
        var res = await RequestAddress.getRequest(autoCompleteUrl);

        if (res['status'] == 'ZERO_RESULTS') {
          isRecordNotFound.value = true;
        } else if (res.containsKey('status') && res['status'] == 'OK') {
          isRecordNotFound.value = false;
          // Parse the predictions from the response
          List<dynamic> result = res['results'];

          // Convert predictions into a list of Map<String, dynamic>
          List<Map<String, dynamic>> resultList =
              result.map((result) => result as Map<String, dynamic>).toList();

          List<PlacesJson> placeList =
              resultList.map((e) => PlacesJson.fromJson(e)).toList();
          pickupPlaceList.value = placeList;
        } else {
          print('Failed to get predictions');
        }
      } catch (error) {
        print('Error: $error');
      }
    }
  }

  Future<void> nearbySearch() async {
    final nearbySearchUrl =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=24.878791105158285,67.05978682516574&radius=100000&key=$GoogleMapAPIKey";
    try {
      var res = await RequestAddress.getRequest(nearbySearchUrl);

      if (res.containsKey('status') && res['status'] == 'OK') {
        // Parse the predictions from the response
        List<dynamic> result = res['results'];

        // Convert predictions into a list of Map<String, dynamic>
        List<Map<String, dynamic>> resultList =
            result.map((result) => result as Map<String, dynamic>).toList();

        List<NearbySearchResult> placeList =
            resultList.map((e) => NearbySearchResult.fromJson(e)).toList();
        nearbyLocationList.value = placeList; // Update nearbyLocationList
      } else {
        print('Failed to get nearby search results');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> placeDetails(String placeId) async {
    try {
      String detailUrl =
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${GoogleMapAPIKey}";

      var res = await RequestAddress.getRequest(detailUrl);

      if (res.containsKey('status') && res['status'] == 'OK') {
        PickupAddress pickupAddress = PickupAddress();
        pickupAddress.pId = placeId;
        pickupAddress.pName = res["result"]["name"];
        pickupAddress.latitude = res["result"]["geometry"]["location"]["lat"];
        pickupAddress.longitude = res["result"]["geometry"]["location"]["lng"];
      } else {
        // Handle API error or no results case
        print('Failed to get predictions');
      }
    } catch (error) {
      // Handle exceptions here
      print('Error: $error');
    }
  }
}
