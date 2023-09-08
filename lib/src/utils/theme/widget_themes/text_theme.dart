import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';

class RsTextTheme {
  RsTextTheme._();

  /* -- Light Text Theme -- */

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(
      color: RsDarkColor,
      fontWeight: FontWeight.bold,
      fontSize: 28.0,
    ),
    displayMedium: GoogleFonts.montserrat(
      color: RsDarkColor,
      fontWeight: FontWeight.w700,
      fontSize: 24.0,
    ),
    displaySmall: GoogleFonts.poppins(
      color: RsDarkColor,
      fontWeight: FontWeight.w700,
      fontSize: 24.0,
    ),
    headlineMedium: GoogleFonts.poppins(
      color: RsDarkColor,
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
    ),
    titleLarge: GoogleFonts.poppins(
      color: RsDarkColor,
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: RsDarkColor,
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: RsDarkColor,
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
    ),
  );

  /* -- Dark Text Theme -- */

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(
      color: RsWhiteColor,
      fontWeight: FontWeight.bold,
      fontSize: 28.0,
    ),
    displayMedium: GoogleFonts.montserrat(
      color: RsWhiteColor,
      fontWeight: FontWeight.w700,
      fontSize: 24.0,
    ),
    displaySmall: GoogleFonts.poppins(
      color: RsWhiteColor,
      fontWeight: FontWeight.w700,
      fontSize: 24.0,
    ),
    headlineMedium: GoogleFonts.poppins(
      color: RsWhiteColor,
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
    ),
    titleLarge: GoogleFonts.poppins(
      color: RsWhiteColor,
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: RsWhiteColor,
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: RsWhiteColor,
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
    ),
  );
}
