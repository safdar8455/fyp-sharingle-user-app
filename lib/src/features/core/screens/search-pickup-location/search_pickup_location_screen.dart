import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/core/controllers/search_pickup_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/search-pickup-location/widgets/search_pickiup_placetile.dart';
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
              Container(
                padding:
                    EdgeInsets.only(top: 10, left: RsDefaultSize, bottom: 2),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Color(0xFFFAFAFA).withOpacity(0.2)
                      : Color(0xFF303030).withOpacity(0.2),
                ),
                child: Text(
                  RsNearbyLoaction,
                  style: Theme.of(context).textTheme.bodyMedium?.apply(
                        color: isDarkMode
                            ? Color(0xFFFAFAFA).withOpacity(0.8)
                            : Color(0xFF303030).withOpacity(0.8),
                      ),
                ),
              ),

              Obx(() {
                if (controller.pickupPlaceList.isNotEmpty) {
                  if (controller.isRecordNotFound.value) {
                    return Container(
                      child: Text("Record is not Found"),
                    );
                  } else {
                    return PickupLocationList(
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

class PickupLocationList extends StatelessWidget {
  const PickupLocationList({
    super.key,
    required this.itemCount,
    required this.listTile,
  });

  final int itemCount;
  final IndexedWidgetBuilder listTile;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          itemBuilder: listTile,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: itemCount,
          physics: ClampingScrollPhysics(),
        ),
      ),
    );
  }
}
