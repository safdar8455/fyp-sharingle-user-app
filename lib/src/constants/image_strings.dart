// App Image String

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

var brightness =
    SchedulerBinding.instance.platformDispatcher.platformBrightness;
bool isDarkMode = brightness == Brightness.dark;

// APP LOGO IMAGE
const String RsAppLogoLight = "assets/logo/rs-app-logo.png";
const String RsAppLogoDark = "assets/logo/rs-app-logo-dark.png";

String RsAppLogo = isDarkMode ? RsAppLogoDark : RsAppLogoLight;

// SPLASH SCREEN IMAGES

const String RsSplashTopIconLight =
    "assets/images/splash_images/splash-top-icon.png";
const String RsSplashTopIconDark =
    "assets/images/splash_images/splash-top-icon-dark.png";
String RsSplashTopIcon =
    isDarkMode ? RsSplashTopIconDark : RsSplashTopIconLight;

const String RsSplashLightImage =
    "assets/images/splash_images/splash-screen-image.png";
const String RsSplashDarkImage =
    "assets/images/splash_images/splash-dark-screen-image.png";
String RsSplashImage = isDarkMode ? RsSplashDarkImage : RsSplashLightImage;

// -- ON BOARDING SCREEN IMAGES

const String RsOnBoardingImage1 =
    "assets/images/on_boarding_images/on_boarding_image_1.png";
const String RsOnBoardingImage2 =
    "assets/images/on_boarding_images/on_boarding_image_2.png";
const String RsOnBoardingImage3 =
    "assets/images/on_boarding_images/on_boarding_image_3.png";

// -- WELCOME SCREEN IMAGES

const String RsWelcomeLightScreenImage =
    "assets/images/welcome_images/welcome-screen-image.png";
const String RsWelcomeDarkScreenImage =
    "assets/images/welcome_images/welcome-dark-screen-image.png";
String RsWelcomeScreenImage =
    isDarkMode ? RsWelcomeDarkScreenImage : RsWelcomeLightScreenImage;

// -- LOGIN & SIGNUP IMAGES

const String RsGoogleLogoImage = "assets/logo/google-logo.png";
const String RsFacebookLogoImage = "assets/logo/facebook-logo.png";

// -- FORGET PASSWORD IMAGES
const String RsForgetPasswordImageLight =
    "assets/images/forget_password/forget-password.png";
const String RsForgetPasswordImageDark =
    "assets/images/forget_password/forget-password-dark.png";
String RsForgetPasswordImage =
    isDarkMode ? RsForgetPasswordImageDark : RsForgetPasswordImageLight;

// -- DASHBOARD IMAGES
const String RsUserProfileImage = "assets/images/dashboard/dash-person.png";
const String RsBannerImage1 = "assets/images/dashboard/dash-01.png";
const String RsBannerImage2 = "assets/images/dashboard/dash-02.png";
const String RsTopProductImage1 = "assets/images/dashboard/dash-03.png";
const String RsTopProductImage2 = "assets/images/dashboard/dash-04.png";
const String RsBike = "assets/images/dashboard/bike-category.png";
const String RsCar = "assets/images/dashboard/car-category.png";
const String RsGoCar = "assets/images/dashboard/go-car-category.png";
const String RsGoPlusCar = "assets/images/dashboard/go-plus-car-category.png";
const String RsPremiumCar = "assets/images/dashboard/premium-car-category.png";
const String RsBannerBike = "assets/images/dashboard/banner-bike.png";
const String RsBannerCar = "assets/images/dashboard/banner-car.png";
const String RsDeals01 = "assets/images/dashboard/dash-deal-01.jpg";
const String RsDeals02 = "assets/images/dashboard/dash-deal-02.jpg";
const String RsDeals03 = "assets/images/dashboard/dash-deal-03.jpg";
const String RsUserProfileMale =
    "https://firebasestorage.googleapis.com/v0/b/fyp-sharingle-user-app.appspot.com/o/profileimages%2Fprofile_male.png?alt=media&token=7973593f-7a03-4869-95d8-f4bb01def943";
const String RsUserProfileFemale =
    "https://firebasestorage.googleapis.com/v0/b/fyp-sharingle-user-app.appspot.com/o/profileimages%2Fprofile_female.png?alt=media&token=ac2e14d1-d4d3-4ca6-9bcc-49239fd82069";
const String RsUserProfileOther =
    "https://firebasestorage.googleapis.com/v0/b/fyp-sharingle-user-app.appspot.com/o/profileimages%2Fprofile_others.png?alt=media&token=3cc49a3e-46b0-426a-9bae-af80d6101370";

// -- PROFILE IMAGES
const String RsProfileImage = "assets/images/profile/profile.jpg";
