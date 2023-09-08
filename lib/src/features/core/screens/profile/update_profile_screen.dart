import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/models/user_model.dart';
import 'package:sharingle_user_app/src/features/core/controllers/profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          RsEditProfile.toUpperCase(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(RsDefaultSize),
          child: Obx(
            () => FutureBuilder(
                future: controller.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      controller.dbUserId.value = userData.id!;
                      controller.dbJoinDate.value = userData.joinDate;
                      controller.dbfullName.value = userData.fullName;
                      controller.updateProfileImgUrl.value =
                          userData.updateProfileImage;
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Obx(
                                () => SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: controller.profilePicture.value !=
                                            null
                                        ? Image(
                                            image: FileImage(controller
                                                .profilePicture.value!))
                                        : Image.network(
                                            userData.updateProfileImage != ""
                                                ? userData.updateProfileImage
                                                : userData.socialProfileImage,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () async {
                                    XFile? selectedImage = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);

                                    if (selectedImage != null) {
                                      CroppedFile? croppedImage =
                                          await ImageCropper().cropImage(
                                        sourcePath: selectedImage.path,
                                        aspectRatio: CropAspectRatio(
                                            ratioX: 1, ratioY: 1),
                                        maxWidth: 800,
                                        maxHeight: 800,
                                      );
                                      if (croppedImage != null) {
                                        File selectedImage =
                                            File(croppedImage.path);
                                        controller.profilePicture.value =
                                            selectedImage;
                                      } else {
                                        Get.snackbar(
                                            "Error", "Image cropping canceled");
                                      }
                                    } else {
                                      Get.snackbar(
                                          "Error", "Image can't selected");
                                    }
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: RsAccentColor.withOpacity(0.7),
                                    ),
                                    child: Icon(LineAwesomeIcons.camera,
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 50),
                          Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: controller.fullName,
                                  decoration: InputDecoration(
                                      label: Text(RsFullName),
                                      prefixIcon: Icon(
                                        Icons.person_outline_rounded,
                                      )),
                                ),
                                SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  value: userData.gender,
                                  items: controller.genderOptions
                                      .map((gender) => DropdownMenuItem<String>(
                                            value: gender,
                                            child: Text(gender),
                                          ))
                                      .toList(),
                                  onChanged: (newValue) {
                                    controller.selectedGender.value =
                                        newValue ?? "Gender";
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Gender",
                                    prefixIcon: Icon(LineAwesomeIcons
                                        .venus_mars), // You can replace this icon
                                  ),
                                ),
                                SizedBox(height: RsDefaultSize),
                                Container(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await controller.updateRecord();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide.none,
                                      shape: StadiumBorder(),
                                    ),
                                    child: Text("Save"),
                                  ),
                                ),
                                SizedBox(height: RsFormHeight),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text.rich(TextSpan(
                                        text: "$RsJoined ",
                                        style: TextStyle(fontSize: 12),
                                        children: [
                                          TextSpan(
                                              text: userData.joinDate,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12))
                                        ])),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        foregroundColor: Colors.red,
                                        backgroundColor:
                                            Colors.red.withOpacity(0.1),
                                        side: BorderSide.none,
                                        shape: StadiumBorder(),
                                      ),
                                      child: Text(RsDelete),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return Center(child: const Text("Something went wrong"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),
    );
  }
}
