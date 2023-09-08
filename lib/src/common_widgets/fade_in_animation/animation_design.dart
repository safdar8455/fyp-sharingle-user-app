import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:sharingle_user_app/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';

class RsFadeInAnimation extends StatelessWidget {
  RsFadeInAnimation({
    Key? key,
    required this.durationInMs,
    required this.child,
    this.animatePosition,
  }) : super(key: key);

  final controller = Get.put(FadeAnimationController());
  final int durationInMs;
  final RsAnimatePosition? animatePosition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
          duration: Duration(milliseconds: durationInMs),
          top: controller.animate.value
              ? animatePosition!.topAfter
              : animatePosition!.topBefore,
          bottom: controller.animate.value
              ? animatePosition!.bottomAfter
              : animatePosition!.bottomBefore,
          left: controller.animate.value
              ? animatePosition!.leftAfter
              : animatePosition!.leftBefore,
          right: controller.animate.value
              ? animatePosition!.rightAfter
              : animatePosition!.rightBefore,
          height: animatePosition!.height,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: durationInMs),
            opacity: controller.animate.value ? 1 : 0,
            child: child,
          )),
    );
  }
}
