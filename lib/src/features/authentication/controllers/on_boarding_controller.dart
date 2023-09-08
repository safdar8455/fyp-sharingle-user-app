import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/models/onboarding/model_on_boarding.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/on_boarding/on_boarding_page_widget.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/welcome/welcome_screen.dart';

class OnBoardingController extends GetxController {
  final LiquidController controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingPageWidget(
        model: OnBoardingModel(
      image: RsOnBoardingImage1,
      title: RsOnBoardingTitle1,
      subTitle: RsOnBoardingSubTitle1,
      counterText: RsOnBoardingCounter1,
      bgColor: RsBoardingPage1Color,
    )),
    OnBoardingPageWidget(
        model: OnBoardingModel(
      image: RsOnBoardingImage2,
      title: RsOnBoardingTitle2,
      subTitle: RsOnBoardingSubTitle2,
      counterText: RsOnBoardingCounter2,
      bgColor: RsBoardingPage2Color,
    )),
    OnBoardingPageWidget(
        model: OnBoardingModel(
      image: RsOnBoardingImage3,
      title: RsOnBoardingTitle3,
      subTitle: RsOnBoardingSubTitle3,
      counterText: RsOnBoardingCounter3,
      bgColor: RsBoardingPage3Color,
    )),
  ];

  onPageChangeCallback(int activePageIndex) =>
      currentPage.value = activePageIndex;

  skip() {
    controller.jumpToPage(page: 2);
  }

  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
    if (nextPage == 3) {
      Get.offAll(() => WelocmeScreen());
    }
  }
}
