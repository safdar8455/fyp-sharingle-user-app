import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/models/user_model.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';
import 'package:sharingle_user_app/src/features/core/controllers/profile_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/widgets/dashboard_appbar.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/widgets/dashboard_categories_widgets.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/widgets/dashboard_enable_location_widget.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/widgets/dashboard_search_box_widget.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/widgets/dashboard_top_banner.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/widgets/dashbord_top_deals_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.put(ProfileController());
    final mapController = Get.put(MapScreenController());

    return SafeArea(
      child: Scaffold(
        appBar: const DashboardAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(RsDashboardPadding),
            child: FutureBuilder(
                future: controller.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hey, ${userData.fullName}.",
                              style: textTheme.bodyLarge),
                          SizedBox(height: RsDashboardPadding - 10),

                          //Search Box
                          DashboardSearchBox(),
                          SizedBox(height: RsDashboardPadding),

                          // TopBanner
                          DashboardTopBannerWidget(),
                          SizedBox(height: RsDashboardPadding),

                          // Enable Location card
                          Obx(() {
                            return mapController.serviceEnabled.value
                                ? Container()
                                : EnableLocationWidget();
                          }),
                          SizedBox(height: RsDashboardPadding),

                          //Categories
                          DashboardCategories(),
                          SizedBox(height: RsDashboardPadding),

                          //Top Deals
                          Center(
                            child: Text(
                              RsDashboardTopDeals.toUpperCase(),
                              style: textTheme.headlineMedium
                                  ?.apply(fontSizeFactor: 1.2),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          DashboardTopDeals(),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return Center(child: const Text("Something went wrong"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),
    );
  }
}
