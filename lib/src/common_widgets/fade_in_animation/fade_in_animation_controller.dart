import 'package:get/get.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';

class FadeAnimationController extends GetxController {
  static FadeAnimationController get find => Get.find();

  RxBool animate = false.obs;

  Future startSplashAnimation() async {
    await Future.delayed(Duration(milliseconds: 800));
    animate.value = true;
    await Future.delayed(Duration(milliseconds: 3000));
    animate.value = false;
    await Future.delayed(Duration(milliseconds: 2000));
    Get.offAll(() => OnBoardingScreen());
  }

  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 800));
    animate.value = true;
  }
}
