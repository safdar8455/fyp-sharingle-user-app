import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';

/*-- Light Dark Outlined Button Themes --*/

class RsOutlinedButtonTheme {
  RsOutlinedButtonTheme._();

/*-- Light Themes --*/
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: RsSecondaryColor,
      side: BorderSide(color: RsSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: RsButtonHeight),
    ),
  );

/*-- Dark Themes --*/
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: RsWhiteColor,
      side: BorderSide(color: RsWhiteColor),
      padding: EdgeInsets.symmetric(vertical: RsButtonHeight),
    ),
  );
}
