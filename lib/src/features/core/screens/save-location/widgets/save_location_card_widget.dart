import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/core/models/save-location/save_location_model.dart';

class SaveLocationCard extends StatelessWidget {
  const SaveLocationCard({
    super.key,
    required this.locationModel,
  });

  final SaveLocationModel locationModel;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xFF303030) : Color(0xFFFAFAFA),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? RsWhiteColor.withOpacity(0.1)
                  : RsDarkColor.withOpacity(0.1), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 10, // Blur radius
              offset: Offset(4, 2), // Offset in x and y
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Image.network(
                "https://maps.googleapis.com/maps/api/staticmap?center=${locationModel.latitude},${locationModel.longitude}&zoom=19&markers=color:red|${locationModel.latitude},${locationModel.longitude}&size=1000x300&key=$GoogleMapAPIKey",
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      LineAwesomeIcons.dot_circle_1,
                      size: 35,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locationModel.placeName,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            locationModel.placeAddress,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
