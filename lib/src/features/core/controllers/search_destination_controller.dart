import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/core/controllers/location-Assestent/request_location.dart';
import 'package:sharingle_user_app/src/features/core/models/search-pickup/placesjson.dart';

class SearchDestinationController extends GetxController {
  static SearchDestinationController get instance => Get.find();

  RxList destinationPlaceList = [].obs;
  RxBool isRecordNotFound = false.obs;
  RxBool isSearhFieldEmply = true.obs;

  TextEditingController searchTextField = TextEditingController();

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
          destinationPlaceList.value = placeList;
        } else {
          print('Failed to get predictions');
        }
      } catch (error) {
        print('Error: $error');
      }
    }
  }
}
