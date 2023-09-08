import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// LIST COLORS

var brightness =
    SchedulerBinding.instance.platformDispatcher.platformBrightness;
bool isDarkMode = brightness == Brightness.dark;

Color primaryColor = Color(0xFF272727);
Color secondaryColor = Color(0xFFFFFFFF);
Color RsCardBgColor = isDarkMode ? Color(0xFF1E1E1E) : Color(0xFFF7F6F1);
Color RsBoardingPage1Color = isDarkMode ? Colors.black : Colors.white;
Color RsBoardingPage2Color = isDarkMode ? Color(0xFF262626) : Color(0xFFFDDCDF);
Color RsBoardingPage3Color = isDarkMode ? Color(0xFF303030) : Color(0xFFFFDCBD);
Color RsAccentColor = isDarkMode ? Color(0xFF64B5F6) : Color(0xFF001BFF);
Color RsCardBgDarkColor = Color(0xFF1E1E1E);
Color RsCardBgLightColor = Color(0xFFF7F6F1);
const RsWhiteColor = Color(0xFFFFFFFF);
const RsDarkColor = Color(0xFF000000);
const RsGoogleBgColor = Color(0xFFB3E5FC);
const RsFacebookBgColor = Color(0xFF3B5998);

const RsPrimaryColor = Color(0xFFE3F2FD);
const RsSecondaryColor = Color(0xFF272727);

// const RsCardBgColor = Color(0xFFF7F6F1);
// const RsAccentColor = Color(0xFF001BFF);

// -- ON BOARDING COLORS
// const RsBoardingPage1Color = Colors.white;
// const RsBoardingPage2Color = Color(0xFFFDDCDF);
// const RsBoardingPage3Color = Color(0xFFFFDCBD);

// DARK MODE COLOR

// const RsDarkPrimaryColor = Color(0xFF121212);
// const RsDarkSecondaryColor = Color(0xFFFFFFFF);
// const RsDarkCardBgColor = Color(0xFF1E1E1E);

// -- ON BOARDING DARK COLORS
// const RsDarkBoardingPage1Color = Colors.black;
// const RsDarkBoardingPage2Color = Color(0xFF262626);
// const RsDarkBoardingPage3Color = Color(0xFF303030);

// Color getPrimaryColor(bool isDarkMode) =>
//     ;
// Color getSecondaryColor(bool isDarkMode) =>
//     isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF272727);
// Color getCardBgColor(bool isDarkMode) =>
//     isDarkMode ? Color(0xFF1E1E1E) : Color(0xFFF7F6F1);
// Color getBoardingPage1Color(bool isDarkMode) =>
//     isDarkMode ? Colors.black : Colors.white;
// Color getBoardingPage2Color(bool isDarkMode) =>
//     isDarkMode ? Color(0xFF262626) : Color(0xFFFDDCDF);
// Color getBoardingPage3Color(bool isDarkMode) =>
//     isDarkMode ? Color(0xFF303030) : Color(0xFFFFDCBD);
