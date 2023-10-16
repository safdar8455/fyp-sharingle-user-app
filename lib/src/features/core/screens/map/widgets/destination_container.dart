import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';
import 'package:sharingle_user_app/src/features/core/controllers/search_destination_controller.dart';
import 'package:sharingle_user_app/src/features/core/models/search-pickup/placesjson.dart';

class DestinationContainer extends StatelessWidget {
  const DestinationContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchDestinationController());
    final mapController = Get.put(MapScreenController());
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    final size = mediaQuery.size;
    return SafeArea(
      child: Container(
        height: size.height * 0.95,
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xFF303030) : RsWhiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: RsDefaultSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      mapController.toggleSheetExpansion();
                    },
                    child: Icon(LineAwesomeIcons.arrow_down),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      shape: CircleBorder(),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(LineAwesomeIcons.calendar),
                        SizedBox(width: 5),
                        Text("Now"),
                        SizedBox(width: 5),
                        Icon(LineAwesomeIcons.arrow_down),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: RsDefaultSize),
              child: Obx(
                () => TextField(
                  controller: controller.searchTextField,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      controller.destinationPlaceList.value = [];
                      controller.isSearhFieldEmply.value = true;
                    } else {
                      controller.autoComplete(value);
                      controller.isSearhFieldEmply.value = false;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: RsEnterYourDestionation,
                    prefixIcon: Icon(LineAwesomeIcons.search),
                    suffixIcon: (controller.isSearhFieldEmply == true)
                        ? null
                        : IconButton(
                            onPressed: () {
                              controller.searchTextField.clear();
                              controller.destinationPlaceList.value = [];
                              controller.isSearhFieldEmply.value = true;
                            },
                            icon: Icon(
                              LineAwesomeIcons.times,
                              color: isDarkMode
                                  ? Color(0xFFFAFAFA)
                                  : Color(0xFF303030),
                            )),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                ),
              ),
            ),
            Obx(() {
              if (controller.isRecordNotFound.value) {
                // Search Location is not Found
                return SuggestionContainer(
                  suggestionIcon: LineAwesomeIcons.exclamation_triangle,
                  suggestionTitle: RsFullSheetErrorTitle,
                  suggestionSubTitle: RsFullSheetErrorSubTitle,
                );
              } else if (controller.destinationPlaceList.isNotEmpty) {
                // Search Location Result
                return SearchResult();
              } else if (controller.isSearhFieldEmply.value == true) {
                // Initially suggestion Content
                return SuggestionContainer(
                  suggestionIcon: LineAwesomeIcons.search,
                  suggestionTitle: RsFullSheetTitle,
                  suggestionSubTitle: RsFullSheetSubTitle,
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchDestinationController());
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          itemBuilder: (context, index) {
            return DestinationPlaceTile(
              key: ValueKey(index),
              destinationPlaceList: controller.destinationPlaceList[index],
              onPlaceSelected: (p0) {},
            );
          },
          itemCount: controller.destinationPlaceList.length,
          physics: ClampingScrollPhysics(),
          separatorBuilder: (context, index) {
            return SizedBox(
                height: 5); // Add a separator between list items if needed
          },
        ),
      ),
    );
  }
}

class SuggestionContainer extends StatelessWidget {
  const SuggestionContainer({
    super.key,
    required this.suggestionIcon,
    required this.suggestionTitle,
    required this.suggestionSubTitle,

  });

  final IconData suggestionIcon;
  final String suggestionTitle;
  final String suggestionSubTitle;


  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapScreenController());
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: RsDefaultSize),
      child: Column(
        children: [
          SizedBox(height: 50),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: Icon(suggestionIcon),
                ),
                SizedBox(height: 20),
                Text(
                  suggestionTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  suggestionSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      mapController.toggleSheetExpansion();
                    },
                    child: Text(RsSelectLocationOnMap),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(RsSkipDestinationStep),
                    style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationPlaceTile extends StatelessWidget {
  final PlacesJson destinationPlaceList;
  final Function(String) onPlaceSelected;

  DestinationPlaceTile({
    required Key key,
    required this.destinationPlaceList,
    required this.onPlaceSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    final mapController = Get.put(MapScreenController());
    if (destinationPlaceList.formattedAddress == null) {
      // Return an empty container or a placeholder widget when data is null
      return Container();
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Color(0xFFFAFAFA).withOpacity(0.2)
                  : Color(0xFF303030).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Image.network(destinationPlaceList.iconUrl!,
                color:
                    isDarkMode ? Colors.grey.shade200 : Colors.grey.shade900),
          ),
          SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                final placeId = destinationPlaceList.place_id ??
                    ""; // Use empty string as default if place_id is null
                onPlaceSelected(placeId);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destinationPlaceList.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    destinationPlaceList.formattedAddress!,
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
                mapController.saveLocation(destinationPlaceList.place_id!);
                
              },
              icon: Icon(LineAwesomeIcons.heart)),
        ],
      ),
    );
  }
}
