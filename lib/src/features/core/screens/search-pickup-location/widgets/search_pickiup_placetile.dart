import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/features/core/models/save-location/save_location_model.dart';
import 'package:sharingle_user_app/src/features/core/models/search-pickup/placesjson.dart';
import 'package:sharingle_user_app/src/features/core/screens/save-location/save_location_screen.dart';

class PlaceTile extends StatelessWidget {
  final PlacesJson pickupPlaceList;
  final Function(String) onPlaceSelected;

  PlaceTile(
      {required Key key,
      required this.pickupPlaceList,
      required this.onPlaceSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pickupPlaceList.formattedAddress == null) {
      // Return an empty container or a placeholder widget when data is null
      return Container();
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                final placeId = pickupPlaceList.place_id ??
                    ""; // Use empty string as default if place_id is null
                onPlaceSelected(placeId);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pickupPlaceList.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    pickupPlaceList.formattedAddress!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
              onPressed: () {
                SaveLocationModel locationModel = SaveLocationModel(
                  placeId: pickupPlaceList.place_id!,
                  placeName: pickupPlaceList.name!,
                  placeAddress: pickupPlaceList.formattedAddress!,
                  latitude: pickupPlaceList.latitude.toString(),
                  longitude: pickupPlaceList.longitude.toString(),
                );
                Get.to(() => SaveLocationScreen(locationModel: locationModel));
              },
              icon: Icon(LineAwesomeIcons.heart)),
        ],
      ),
    );
  }
}
