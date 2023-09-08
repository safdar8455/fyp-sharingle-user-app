import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';

class RsTextFormFieldTheme {
  RsTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(),
      prefixIconColor: RsSecondaryColor,
      floatingLabelStyle: TextStyle(color: RsSecondaryColor),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
        width: 2,
        color: RsSecondaryColor,
      )));

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(),
      prefixIconColor: RsPrimaryColor,
      floatingLabelStyle: TextStyle(color: RsPrimaryColor),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
        width: 2,
        color: RsPrimaryColor,
      )));
}
