import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';

class TopDealsCardModel {
  final String dealsTitle;
  final String dealsSubTitle;
  final String dealsBgImage;
  final VoidCallback onPress;

  TopDealsCardModel(
    this.dealsTitle,
    this.dealsSubTitle,
    this.dealsBgImage,
    this.onPress,
  );

  static List<TopDealsCardModel> list = [
    TopDealsCardModel("basic deals", "COMING SOON", RsDeals01, () {}),
    TopDealsCardModel("Standard deals", "COMING SOON", RsDeals02, () {}),
    TopDealsCardModel("Premium", "COMING SOON", RsDeals03, () {}),
  ];
}
