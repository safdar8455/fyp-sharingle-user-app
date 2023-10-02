import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/core/controllers/search_pickup_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/search-pickup-location/widgets/search_pickiup_placetile.dart';
import 'package:sharingle_user_app/src/features/core/screens/search-pickup-location/widgets/search_pickup_location_list.dart';
import 'package:sharingle_user_app/src/features/core/screens/search-pickup-location/widgets/search_pickup_resultnotfound.dart';
import 'package:sharingle_user_app/src/features/core/screens/search-pickup-location/widgets/search_prckup_nearbylocation_tile.dart';

class SearchPickLocationScreen extends StatelessWidget {
  const SearchPickLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;

    final controller = Get.put(SearchPickupController());

    return SafeArea(
      child: Scaffold(
        body: Container(
          // padding: EdgeInsets.all(RsDefaultSize),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: RsDefaultSize),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: isDarkMode
                          ? Color(0xFFFAFAFA).withOpacity(0.5)
                          : Color(0xFF303030).withOpacity(0.5),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(LineAwesomeIcons.arrow_left, size: 30),
                        ),
                        SizedBox(width: 20),
                        Text(
                          RsSearch,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        if (value.isEmpty) {
                          // If the text field is empty, clear the pickupPlaceList
                          controller.pickupPlaceList.value = [];
                        } else {
                          controller.autoComplete(value);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: RsSearchforLocation,
                        prefixIcon: Icon(LineAwesomeIcons.search),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              // Near by me container

              Obx(() {
                if (controller.pickupPlaceList.isNotEmpty) {
                  if (controller.isRecordNotFound.value) {
                    return SearchPickupResultNotFound();
                  } else {
                    return PickupLocationList(
                      title: RsSearchResult,
                      listTile: (context, index) {
                        return PlaceTile(
                          key: ValueKey(index),
                          pickupPlaceList: controller.pickupPlaceList[index],
                          onPlaceSelected: controller.placeDetails,
                        );
                      },
                      itemCount: controller.pickupPlaceList.length,
                    );
                  }
                } else if (controller.pickupPlaceList.isEmpty ||
                    controller.isSearhFieldEmply.value == true) {
                  return PickupLocationList(
                    title: RsNearbyLoaction,
                    itemCount: controller.nearbyLocationList.length,
                    listTile: (context, index) {
                      return NearByLocationTile(
                        key: ValueKey(index),
                        nearbyPlaceList: controller.nearbyLocationList[index],
                        onPlaceSelected: controller.placeDetails,
                      );
                    },
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
