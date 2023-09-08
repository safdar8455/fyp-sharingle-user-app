import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';

class CategoryItemModel {
  final String categTitle;
  final String categSubTite;
  final String categIconImage;
  final VoidCallback? onpress;

  CategoryItemModel(
    this.categTitle,
    this.categSubTite,
    this.categIconImage,
    this.onpress,
  );

  static List<CategoryItemModel> list = [
    CategoryItemModel("Bike Ride", "Go Your Own Way", RsBike, null),
    CategoryItemModel("Mini Car Ride", "Go Your Own Way", RsCar, null),
    CategoryItemModel("Car Ride", "Go Your Own Way", RsGoCar, null),
    CategoryItemModel("Go Plus Car Ride", "Go Your Own Way", RsGoPlusCar, null),
    CategoryItemModel(
        "Premium Car Ride", "Go Your Own Way", RsPremiumCar, null),
  ];
}
