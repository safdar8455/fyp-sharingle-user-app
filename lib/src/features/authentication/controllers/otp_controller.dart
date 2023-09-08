import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/features/authentication/models/user_model.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/more-information/more_information_screen.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/darshboard.dart';
import 'package:sharingle_user_app/src/repository/authentication_repository/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  Future<void> verifyOTP(String otp) async {
    try {
      var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
      String email = await FirebaseAuth.instance.currentUser!.email.toString();
      if (isVerified) {
        final isProfileComplete = await getUserDetails(email);
        if (!isProfileComplete) {
          Get.offAll(() => const DashboardScreen());
        } else {
          Get.offAll(() => MoreInfoScreen());
        }
      }

      // isVerified ? Get.offAll(() => const MoreInfoScreen()) : Get.back();
    } catch (e) {
      Get.snackbar("Error",
          "The OTP entered is incorrect. Please enter correct OTP or try regenerating the OTP");
    }
  }

  Future<bool> getUserDetails(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .where("Email", isEqualTo: email)
        .get();

    return snapshot.docs.map((e) => UserModel.fromSnapshot(e)).isEmpty;
  }

  // Future<void> verifyOTPAndLinkPhoneNumber(String otp) async {
  //   try {
  //     bool isLinked =
  //         await AuthenticationRepository.instance.linkPhoneNumber(otp);
  //     isLinked ? Get.offAll(() => const DashboardScreen()) : Get.back();
  //   } catch (e) {
  //     // Handle any errors that occur during the process
  //     print("Error during OTP verification and phone linking: $e");
  //     // Display an error message to the user
  //     Get.snackbar("Error", "An error occurred during phone linking.");
  //   }
  // }
}
