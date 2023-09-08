// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/models/user_model.dart';
import 'package:sharingle_user_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:sharingle_user_app/src/repository/user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  GlobalKey<FormState> profileUpdateFormKey = GlobalKey<FormState>();
  final firebaseUser = AuthenticationRepository.instance.firebaseUser;
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  var selectedGender = "Male".obs;
  RxString dbfullName = "".obs;
  RxString dbUserId = "".obs;
  RxString dbJoinDate = "".obs;
  RxString socialProfileImage = "".obs;
  RxString updateProfileImgUrl = "".obs;

  /// Loader
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  Rx<File?> profilePicture = Rx<File?>(null);

  TextEditingController fullName = TextEditingController();

  final List<String> genderOptions = ["Male", "Female", "Other"];

  @override
  void onInit() {
    ever(dbfullName, (String? value) {
      fullName.text = value ?? "";
    });
    super.onInit();
  }

  getUserData() async {
    final email = _authRepo.firebaseUser!.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  /// Fetch List of user recode
  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUsers();

  updateRecord() async {
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

    if (profilePicture.value != null) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("profileimages")
          .child(Uuid().v1())
          .putFile(profilePicture.value!);

      StreamSubscription taskSubscription =
          uploadTask.snapshotEvents.listen((snapshot) {
        double percentage =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      });

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      taskSubscription.cancel();
      updateProfileImgUrl.value = downloadUrl;
    } else {
      updateProfileImgUrl.value = updateProfileImgUrl.value;
    }
    // profilePicture.value = null;
    final user = UserModel(
      id: dbUserId.value,
      fullName: fullName.text.trim(),
      email: AuthenticationRepository.instance.getUserEmail,
      socialProfileImage: socialProfileImage.value,
      updateProfileImage: updateProfileImgUrl.value,
      gender: selectedGender.value,
      joinDate: dbJoinDate.value,
    );
    await _userRepo.updateUserRecord(user);
  }
}
