import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/features/core/screens/profile/update_profile_screen.dart';

class ProfileTopSheet {
  static Future<void> profileTopSheet(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    final size = mediaQuery.size;
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.0, -1.0),
                    end: Offset(0.0, 0.0),
                  ).animate(animation),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Color(0xFF303030) : RsWhiteColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                            ),
                            Image(
                              image: isDarkMode
                                  ? AssetImage(RsAppLogoDark)
                                  : AssetImage(RsAppLogoLight),
                              height: size.height * 0.02,
                              alignment: Alignment.topRight,
                            ),
                            OutlinedButton(
                              onPressed: () => Get.back(),
                              child: Icon(LineAwesomeIcons.times),
                              style: OutlinedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: RsDefaultSize),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TopSheetOption(
                              title: "Home",
                              iconData: LineAwesomeIcons.home,
                              onPress: () => Get.back(),
                            ),
                            TopSheetOption(
                              title: "Help",
                              iconData: Icons.support_agent_rounded,
                              onPress: () {},
                            ),
                            TopSheetOption(
                              title: "Activities",
                              iconData: LineAwesomeIcons.clock,
                              onPress: () {},
                            ),
                            TopSheetOption(
                              title: "Profile",
                              iconData: LineAwesomeIcons.user,
                              onPress: () =>
                                  Get.to(() => const UpdateProfileScreen()),
                            ),
                          ],
                        ),
                        SizedBox(height: RsDefaultSize),
                        Container(
                          height: 5,
                          width: 80,
                          decoration: BoxDecoration(
                            color:
                                isDarkMode ? RsWhiteColor : Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TopSheetOption extends StatelessWidget {
  const TopSheetOption({
    super.key,
    required this.iconData,
    required this.title,
    required this.onPress,
  });

  final IconData iconData;
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        OutlinedButton(
          onPressed: onPress,
          child: Icon(iconData),
          style: OutlinedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.all(10),
            shape: CircleBorder(),
          ),
        ),
        SizedBox(height: 5),
        Text(title, style: textTheme.titleSmall),
      ],
    );
  }
}
