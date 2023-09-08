import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/features/core/models/dashboard/dashboard_banner_model.dart';

class DashboardBanner extends StatelessWidget {
  const DashboardBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final list = BannerCardModel.list;
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => SizedBox(
          height: 160,
          width: 320,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isDarkMode ? RsCardBgDarkColor : RsCardBgLightColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Image(
                      image: isDarkMode
                          ? AssetImage(RsAppLogoDark)
                          : AssetImage(RsAppLogoLight),
                      width: size.height * 0.15,
                    )),
                    Flexible(
                        child: Image(
                      image: AssetImage(list[index].bannerImage),
                      width: size.height * 0.5,
                    )),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list[index].bannerTitle,
                          style: textTheme.headlineMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          list[index].bannerSubTitle,
                          style: textTheme.bodyLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, right: 20),
                      child: SizedBox(
                        height: 30,
                        child: OutlinedButton(
                            onPressed: list[index].onPress,
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 15.0),
                              elevation: 0,
                            ),
                            child: Text("Book Now")),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
