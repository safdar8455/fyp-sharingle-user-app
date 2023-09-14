import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/models/user_model.dart';
import 'package:sharingle_user_app/src/features/core/controllers/profile_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/darshboard.dart';
import 'package:sharingle_user_app/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:sharingle_user_app/src/features/core/screens/profile/widgets/profile_menu.dart';
import 'package:sharingle_user_app/src/repository/authentication_repository/authentication_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    final textTheme = Theme.of(context).textTheme;
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.to(() => const DashboardScreen()),
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          RsProfile.toUpperCase(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              isDarkMode ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
            ),
          ),
        ],
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(RsDefaultSize),
          child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data as UserModel;

                    return Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  userData.updateProfileImage != ""
                                      ? userData.updateProfileImage
                                      : userData.socialProfileImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => UpdateProfileScreen());
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: RsAccentColor.withOpacity(0.7),
                                  ),
                                  child: Icon(LineAwesomeIcons.alternate_pencil,
                                      color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Text(userData.fullName,
                            style: textTheme.headlineMedium),
                        Text(userData.email, style: textTheme.bodyMedium),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Future.delayed(Duration.zero, () {
                                Get.to(() => UpdateProfileScreen());
                              });
                            },
                            child: Text(RsEditProfile),
                            style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              shape: const StadiumBorder(),
                            ),
                          ),
                        ),
                        SizedBox(height: RsDefaultSize),
                        const Divider(),

                        //Profile Menu
                        ProfileMenuWidget(
                          title: RsMenu1,
                          icon: LineAwesomeIcons.cog,
                          onPress: () {},
                        ),
                        ProfileMenuWidget(
                          title: RsMenu2,
                          icon: LineAwesomeIcons.wallet,
                          onPress: () {},
                        ),
                        ProfileMenuWidget(
                          title: RsMenu3,
                          icon: LineAwesomeIcons.user_check,
                          onPress: () {},
                        ),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10),
                        ProfileMenuWidget(
                          title: RsMenu4,
                          icon: LineAwesomeIcons.info,
                          onPress: () {},
                        ),
                        ProfileMenuWidget(
                          title: RsMenu5,
                          icon: LineAwesomeIcons.alternate_sign_out,
                          textColor: Colors.red,
                          endIcon: false,
                          onPress: () =>
                              AuthenticationRepository.instance.logout(),
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
    );
  }
}
