import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/models/user_model.dart';
import 'package:sharingle_user_app/src/features/core/controllers/profile_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/widgets/profile-top-sheet/profile_topsheet.dart';
import 'package:sharingle_user_app/src/features/core/screens/profile/profile_screen.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    final controller = Get.put(ProfileController());

    return Container(
      margin: EdgeInsets.only(top: 2, right: 10),
      child: FutureBuilder(
          future: controller.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel userData = snapshot.data as UserModel;
                return AppBar(
                  leading: GestureDetector(
                    onTap: () => Get.offAll(() => const ProfileScreen()),
                    child: Icon(Icons.menu),
                  ),
                  title: Image(
                    image: isDarkMode
                        ? AssetImage(RsAppLogoDark)
                        : AssetImage(RsAppLogoLight),
                    height: size.height * 0.02,
                  ),
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    IconButton(
                      onPressed: () {
                        ProfileTopSheet.profileTopSheet(context);
                      },
                      padding: EdgeInsets.all(0.0),
                      icon: CircleAvatar(
                        backgroundImage: NetworkImage(
                          userData.updateProfileImage != ""
                              ? userData.updateProfileImage
                              : userData.socialProfileImage,
                        ),
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
