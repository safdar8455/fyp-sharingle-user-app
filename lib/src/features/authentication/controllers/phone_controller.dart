import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore_for_file: body_might_complete_normally_catch_error
import 'package:sharingle_user_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:sharingle_user_app/src/repository/user_repository/user_repository.dart';

class PhoneLinkController extends GetxController {
  static PhoneLinkController get instance => Get.find();
  final UserRepo = Get.put(UserRepository());
  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  /// Loader
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  Future<void> phoneAuthentication(var phoneNo) async {
    try {
      isLoading.value = true;

      if (!phoneFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      final auth = AuthenticationRepository.instance;
      await auth.phoneAuthentication(phoneNo);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }
}
