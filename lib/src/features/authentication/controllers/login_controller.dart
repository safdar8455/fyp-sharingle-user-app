// ignore_for_file: body_might_complete_normally_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/models/user_model.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/more-information/more_information_screen.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/phone-number-Screen/phone_no_screen.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/darshboard.dart';
import 'package:sharingle_user_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:sharingle_user_app/src/repository/controller/helper_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final showPassword = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// Loader
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  //Call the function from the Design
  Future<void> login() async {
    try {
      isLoading.value = true;
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
      final auth = await AuthenticationRepository.instance;
      auth.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      auth.setInitialLoginScreen(auth.firebaseUser);
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      // Helper.errorSnackBar(title: RsOhSnap, message: error.toString());
      print(error.toString());
    }
  }

  Future<void> ResetEmail() async {
    try {
      isLoading.value = true;
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
      final auth = await AuthenticationRepository.instance;
      auth.ResetUserWithEmail(email.text.trim()).whenComplete(() {
        Get.snackbar(
          "Successfully Reset",
          "We have successfully sent a reset link to your email.",
        );
        email.clear(); // Clear the email text field on success
        isLoading.value = false;
      }).catchError((error, stackTracer) {
        Get.snackbar("Error", "Something went wrong. Try again.");
      });
    } catch (error) {
      isLoading.value = false;
      Helper.errorSnackBar(title: RsOhSnap, message: error.toString());
      print(error.toString());
    }
  }

  /// [GoogleSiginAuthentication]
  Future<void> googleSignIn() async {
    try {
      isGoogleLoading.value = true;
      final auth = AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      String email = await FirebaseAuth.instance.currentUser!.email.toString();
      if (auth.firebaseUser!.phoneNumber == null) {
        Get.offAll(() => const PhoneScreen());
      } else {
        final isProfileComplete = await getUserDetails(email);
        if (!isProfileComplete) {
          Get.offAll(() => const DashboardScreen());
        } else {
          Get.offAll(() => MoreInfoScreen());
        }
      }
      isGoogleLoading.value = false;
      // auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isGoogleLoading.value = false;
      Helper.errorSnackBar(title: RsOhSnap, message: e.toString());
    }
  }

  /// [FacebookSiginAuthentication]
  Future<void> facebookSignIn() async {
    try {
      isFacebookLoading.value = true;
      final auth = AuthenticationRepository.instance;
      await auth.signInWithFacebook();
      String email = await FirebaseAuth.instance.currentUser!.email.toString();
      if (auth.firebaseUser!.phoneNumber == null) {
        Get.offAll(() => const PhoneScreen());
      } else {
        final isProfileComplete = await getUserDetails(email);
        if (!isProfileComplete) {
          Get.offAll(() => const DashboardScreen());
        } else {
          Get.offAll(() => MoreInfoScreen());
        }
      }

      isFacebookLoading.value = false;
    } catch (e) {
      isFacebookLoading.value = false;
      Helper.errorSnackBar(title: RsOhSnap, message: e.toString());
    }
  }

  Future<bool> getUserDetails(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .where("Email", isEqualTo: email)
        .get();

    return snapshot.docs.map((e) => UserModel.fromSnapshot(e)).isEmpty;
  }
}
