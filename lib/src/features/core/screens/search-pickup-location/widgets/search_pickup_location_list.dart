import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';

class PickupLocationList extends StatelessWidget {
  const PickupLocationList({
    super.key,
    required this.itemCount,
    required this.listTile,
    required this.title,
  });

  final int itemCount;
  final IndexedWidgetBuilder listTile;
  final String title;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: RsDefaultSize, bottom: 2),
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Color(0xFFFAFAFA).withOpacity(0.2)
                  : Color(0xFF303030).withOpacity(0.2),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.apply(
                    color: isDarkMode
                        ? Color(0xFFFAFAFA).withOpacity(0.8)
                        : Color(0xFF303030).withOpacity(0.8),
                  ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.all(0.0),
                itemBuilder: listTile,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: itemCount,
                physics: ClampingScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
