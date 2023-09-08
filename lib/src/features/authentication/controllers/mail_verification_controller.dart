import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/models/user_model.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/more-information/more_information_screen.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/phone-number-Screen/phone_no_screen.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/darshboard.dart';
import 'package:sharingle_user_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:sharingle_user_app/src/repository/controller/helper_controller.dart';

class MailVerificationController extends GetxController {
  static MailVerificationController get instance => Get.find();
  // ignore: unused_field
  late Timer _timer;
  @override
  void onInit() {
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect();
  }

  /// Send OR Resend Email Verification
  void sendVerificationEmail() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {
      Helper.errorSnackBar(title: RsOhSnap, message: e.toString());
    }
  }

  /// -- Set Timer to Check if Verification Completed then Redirect
  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        // AuthenticationRepository.instance.setInitialScreen(user);
        if (user.phoneNumber != null) {
          final isProfileComplete = await getUserDetails(user.email.toString());
          if (!isProfileComplete) {
            Get.offAll(() => const DashboardScreen());
          } else {
            Get.offAll(() => MoreInfoScreen());
          }
        } else {
          Get.offAll(() => const PhoneScreen());
        }
      }
    });
  }

  /// -- manually check if verification Completed then Redirect
  void manuallyCheckEmailVerificationStatus() async {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      if (user.phoneNumber != null) {
        final isProfileComplete = await getUserDetails(user.email.toString());
        if (!isProfileComplete) {
          Get.offAll(() => const DashboardScreen());
        } else {
          Get.offAll(() => MoreInfoScreen());
        }
      } else {
        Get.offAll(() => const PhoneScreen());
      }
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
