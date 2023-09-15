import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/features/core/screens/map/widgets/map_topsheet.dart';

class MapScreenTopBar extends StatelessWidget {
  const MapScreenTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 200,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE5E5E5).withOpacity(0.9),
              Color(0xFFE5E5E5).withOpacity(0.0),
            ],
            stops: [0.4, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF272727),
                          width: 1.0,
                        )),
                    child: Icon(
                      Icons.close,
                      color: Color(0xFF272727),
                    ),
                  ),
                ),
                Image(
                  image: AssetImage(RsAppLogoLight),
                  height: size.height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    MapTopSheet.mapTopSheet(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF272727),
                          width: 1.0,
                        )),
                    child: Icon(
                      Icons.menu,
                      color: Color(0xFF272727),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
