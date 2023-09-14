import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/features/core/screens/pickup-location/widgets/pickup_location_appbar.dart';
import 'package:sharingle_user_app/src/features/core/screens/pickup-location/widgets/pickup_location_searchbox.dart';

class PickupLocationScreen extends StatelessWidget {
  const PickupLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: PickupLocationAppBar(),
      body: Container(
        padding: EdgeInsets.all(RsDefaultSize - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text("Pickup Location",
                style: Theme.of(context).textTheme.displayLarge),
            SizedBox(height: RsFormHeight),

            // SearchBox of pickup location
            PickupSearchBox(),
            SizedBox(height: RsFormHeight),

            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? RsWhiteColor.withOpacity(0.1)
                        : RsDarkColor.withOpacity(0.1), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 20, // Blur radius
                    offset: Offset(0, 2), // Offset in x and y
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: isDarkMode ? RsCardBgDarkColor : RsCardBgLightColor,
              ),
              child: Column(
                children: [
                  Text(
                    "SHARINGLE requires access to your location",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Enable location services for a mpre accurate pickup experience",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: RsFormHeight),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Trun o location services"),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
