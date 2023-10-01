import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/features/core/models/search-pickup/nearbylocationjson.dart';

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
          IconButton(onPressed: () {}, icon: Icon(LineAwesomeIcons.heart)),
        ],
      ),
    );
  }
}