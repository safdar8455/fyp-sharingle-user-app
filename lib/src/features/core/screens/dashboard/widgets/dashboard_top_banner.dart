import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/features/core/controllers/top_banner_controller.dart';
import 'package:sharingle_user_app/src/features/core/models/dashboard/dashboard_top_banner.dart';
import 'package:sharingle_user_app/src/features/core/screens/pickup-location/pickup_location_screen.dart';

class DashboardTopBannerWidget extends StatelessWidget {
  const DashboardTopBannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final CarouselController carouselControtter = CarouselController();
    final animationCtrl = Get.put(TopBannerController());
    RxInt currentIndex = 0.obs;
    final list = TopBanner.list;
    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () => Get.to(() => const PickupLocationScreen()),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                          ? RsWhiteColor.withOpacity(0.2)
                          : RsDarkColor.withOpacity(0.2), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 10, // Blur radius
                      offset: Offset(0, 2), // Offset in x and y
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(RsDefaultSize - 10),
                  child: CarouselSlider(
                    items: list.map((item) {
                      return Image.asset(
                        item.bannerImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    }).toList(),
                    carouselController:
                        carouselControtter, // Use your controller here
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 1,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        currentIndex.value = index;
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: list.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselControtter.animateToPage(entry.key),
                    child: AnimatedBuilder(
                      animation: animationCtrl.animationController,
                      builder: (context, child) {
                        final isSelected = currentIndex.value == entry.key;

                        final width = isSelected
                            ? IntTween(begin: 7, end: 27)
                                .animate(animationCtrl.animationController)
                                .value
                            : 5;
                        return Container(
                          width:
                              width.toDouble(), // Convert to double for width
                          height: currentIndex.value == entry.key ? 7 : 5,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                                spreadRadius: 0.5,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: isSelected
                                ? Colors.deepPurple
                                : Colors.red.withOpacity(0.8),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        )
      ],
    );
  }
}
