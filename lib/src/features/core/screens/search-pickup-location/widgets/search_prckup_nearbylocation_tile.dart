import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/features/core/models/save-location/save_location_model.dart';
import 'package:sharingle_user_app/src/features/core/models/search-pickup/nearbylocationjson.dart';
import 'package:sharingle_user_app/src/features/core/screens/save-location/save_location_screen.dart';

class NearByLocationTile extends StatelessWidget {
  final NearbySearchResult nearbyPlaceList;
  final Function(String) onPlaceSelected;

  NearByLocationTile(
      {required Key key,
      required this.nearbyPlaceList,
      required this.onPlaceSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (nearbyPlaceList.vicinity == null) {
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
                final placeId = nearbyPlaceList.placeId ??
                    ""; // Use empty string as default if place_id is null
                onPlaceSelected(placeId);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nearbyPlaceList.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    nearbyPlaceList.vicinity!,
                    maxLines: 1,
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
                  placeId: nearbyPlaceList.placeId!,
                  placeName: nearbyPlaceList.name!,
                  placeAddress: nearbyPlaceList.vicinity!,
                  latitude: nearbyPlaceList.latitude.toString(),
                  longitude: nearbyPlaceList.longitude.toString(),
                );
                Get.to(() => SaveLocationScreen(locationModel: locationModel));
              },
              icon: Icon(LineAwesomeIcons.heart)),
        ],
      ),
    );
  }
}
