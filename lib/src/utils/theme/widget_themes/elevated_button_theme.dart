import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';

/*-- Light Dark Elevated Button Themes --*/

class RsElevatedButtonTheme {
  RsElevatedButtonTheme._();

/*-- Light Themes --*/
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: RsWhiteColor,
      elevation: 0,
      backgroundColor: RsSecondaryColor,
      side: BorderSide(color: RsSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: RsButtonHeight),
    ),
  );

/*-- Dark Themes --*/
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: RsSecondaryColor,
      elevation: 0,
      backgroundColor: RsWhiteColor,
      side: BorderSide(color: RsWhiteColor),
      padding: EdgeInsets.symmetric(vertical: RsButtonHeight),
    ),
  );
}
