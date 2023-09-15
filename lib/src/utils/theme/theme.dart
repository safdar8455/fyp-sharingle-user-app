import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:sharingle_user_app/src/utils/theme/widget_themes/icon_button_theme.dart';
import 'package:sharingle_user_app/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:sharingle_user_app/src/utils/theme/widget_themes/text_field_theme.dart';
import 'package:sharingle_user_app/src/utils/theme/widget_themes/text_theme.dart';

class RsAppTheme {
  RsAppTheme._();
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: RsTextTheme.lightTextTheme,
    outlinedButtonTheme: RsOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: RsElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: RsTextFormFieldTheme.lightInputDecorationTheme,
    iconTheme: RsIconTheme.lightIconThemeData,
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
    
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: RsTextTheme.darkTextTheme,
    outlinedButtonTheme: RsOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: RsElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: RsTextFormFieldTheme.darkInputDecorationTheme,
    iconTheme: RsIconTheme.darkIconThemeData,
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
  );
}
