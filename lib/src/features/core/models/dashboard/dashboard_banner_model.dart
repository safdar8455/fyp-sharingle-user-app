import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';

class BannerCardModel {
  final String bannerTitle;
  final String bannerSubTitle;
  final String bannerImage;
  final VoidCallback onPress;

  BannerCardModel(
    this.bannerTitle,
    this.bannerSubTitle,
    this.bannerImage,
    this.onPress,
  );

  static List<BannerCardModel> list = [
    BannerCardModel(
        RsDashboardBannerTitle1, RsDashboardBannerSubTitle, RsBannerCar, () {}),
    BannerCardModel(RsDashboardBannerTitle2, RsDashboardBannerSubTitle,
        RsBannerBike, () {}),
  ];
}
