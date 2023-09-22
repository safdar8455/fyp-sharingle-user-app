import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/models/user_model.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/darshboard.dart';
// ignore_for_file: body_might_complete_normally_catch_error
import 'package:sharingle_user_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:sharingle_user_app/src/repository/user_repository/user_repository.dart';

class MoreInfoController extends GetxController {
  static MoreInfoController get instance => Get.find();
  final UserRepo = Get.put(UserRepository());
  String joinDate = DateFormat('d MMM yyyy').format(DateTime.now());
  final firebaseUser = AuthenticationRepository.instance.firebaseUser;
  GlobalKey<FormState> moreInfoKey = GlobalKey<FormState>();

  TextEditingController fullName = TextEditingController();

  var selectedGender = "Gender".obs;
  final List<String> genderOptions = ["Gender", "Male", "Female", "Other"];

  RxString socialProfileImage = "".obs;

  /// Loader
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  Future<void> submitInformation() async {
    try {
      isLoading.value = true;

      if (!moreInfoKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      } else if (selectedGender.value == "Gender" ||
          fullName.text.trim() == "") {
        Get.snackbar("Error", "Please fill your entries.");
        isLoading.value = false;
      } else {
        if (firebaseUser != null && firebaseUser!.photoURL != null) {
          socialProfileImage.value = firebaseUser!.photoURL!;
        } else {
          if (selectedGender.value == "Male") {
            socialProfileImage.value = RsUserProfileMale;
          } else if (selectedGender.value == "Female") {
            socialProfileImage.value = RsUserProfileFemale;
          } else {
            socialProfileImage.value = RsUserProfileOther;
          }
        }
        UserModel user = UserModel(
          fullName: fullName.text.trim(),
          email: AuthenticationRepository.instance.getUserEmail,
          gender: selectedGender.value,
          socialProfileImage: socialProfileImage.value,
          updateProfileImage: "",
          joinDate: joinDate,
        );
        // final auth = AuthenticationRepository.instance;
        await UserRepository.instance.createUser(user).whenComplete(() {
          MapScreenController().checkLocationPermission();
          Get.offAll(() => const DashboardScreen());
        }).catchError((error, stackTrace) {
          Get.snackbar("Error", "Something went wrong. Try again");
        });
      }
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
