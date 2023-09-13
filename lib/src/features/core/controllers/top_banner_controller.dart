import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBannerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void onInit() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animationController.forward();
    animationController.repeat();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    animationController.stop();
    animationController.dispose();
  }
}
