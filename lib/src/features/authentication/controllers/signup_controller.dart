import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/mail-verification/mail_verification.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/phone-number-Screen/phone_no_screen.dart';
// ignore_for_file: body_might_complete_normally_catch_error
import 'package:sharingle_user_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:sharingle_user_app/src/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final UserRepo = Get.put(UserRepository());
  // final _db = FirebaseFirestore.instance;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final showPassword = false.obs;

  /// Loader
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  /// Register New User using either [EmailAndPassword] OR [PhoneNumber] authentication

  Future<void> createUser() async {
    try {
      isLoading.value = true;

      if (!signupFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      final auth = AuthenticationRepository.instance;
      await auth.createUserWithEmaiAndPassword(email.text.tr, password.text.tr);
      if (auth.firebaseUser!.emailVerified) {
        Get.offAll(() => const PhoneScreen());
      } else {
        Get.offAll(() => const MailVerification());
      }

      // auth.setInitialScreen(auth.firebaseUser);
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

  /// [PhoneNoAuthentication]
  Future<void> phoneAuthentication(String phoneNo) async {
    try {
      AuthenticationRepository.instance.phoneAuthentication(phoneNo);
    } catch (e) {
      throw e.toString();
    }
  }
}
