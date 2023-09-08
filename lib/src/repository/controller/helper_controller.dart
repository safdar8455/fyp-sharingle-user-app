import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';

class Helper extends GetxController {
  /* -- ============= VALIDATIONS ============= -- */

  static String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email address';
    }

    return null; // Return null if validation is successful
  }

  static String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null; // Return null if validation is successful
  }

  static successSnackBar({required title, message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: RsWhiteColor,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.all(RsDefaultSize - 10),
      icon: const Icon(LineAwesomeIcons.check_circle, color: RsWhiteColor),
    );
  }

  static void warningSnackBar({required title, message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: RsWhiteColor,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.all(RsDefaultSize - 10),
      icon: const Icon(LineAwesomeIcons.exclamation_triangle,
          color: RsWhiteColor),
    );
  }

  static void errorSnackBar({required title, message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.red,
      backgroundColor: Colors.red.withOpacity(0.1),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.all(RsDefaultSize - 10),
      icon: const Icon(LineAwesomeIcons.times_circle, color: RsWhiteColor),
    );
  }

  static void modernSnackBar({required title, message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.black87,
      backgroundColor: Colors.grey.withOpacity(0.1),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.all(RsDefaultSize - 10),
      icon: const Icon(LineAwesomeIcons.info_circle, color: RsWhiteColor),
    );
  }
}
