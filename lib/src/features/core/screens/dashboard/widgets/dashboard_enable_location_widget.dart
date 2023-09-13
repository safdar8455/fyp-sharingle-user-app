import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';

class EnableLocationWidget extends StatelessWidget {
  const EnableLocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? RsWhiteColor.withOpacity(0.2)
                : RsDarkColor.withOpacity(0.2), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 20, // Blur radius
            offset: Offset(0, 2), // Offset in x and y
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: isDarkMode ? RsCardBgDarkColor : RsCardBgLightColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Center(child: Icon(LineAwesomeIcons.paper_plane)),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Turn on Location services.",
                    style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 5),
                Text("Please enable locations for a better experience.",
                    style: Theme.of(context).textTheme.bodySmall),
                SizedBox(height: 15),
                SizedBox(
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Enable Locations"),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
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
