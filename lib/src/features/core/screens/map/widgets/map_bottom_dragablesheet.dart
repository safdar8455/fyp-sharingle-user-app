// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/features/core/controllers/map_screen_controller.dart';
import 'package:sharingle_user_app/src/features/core/screens/map/widgets/destination_container.dart';
import 'package:sharingle_user_app/src/features/core/screens/map/widgets/initial_container.dart';

class BottomDraggableSheet extends StatelessWidget {
  const BottomDraggableSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapScreenController());
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    final size = mediaQuery.size;
    final scrollController = ScrollController();

    return Obx(
      () {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            mapController.sheetPosition.value = notification.extent;

            return true;
          },
          child: DraggableScrollableSheet(
            initialChildSize: mapController.sheetPosition.value.clamp(
              mapController.isDestinationSelectedPointer.value? 0.3:0.25,
              1.0,
            ),
            minChildSize: mapController.isDestinationSelectedPointer.value? 0.3:0.25,
            maxChildSize: 1.0,
            snap: true,
            // controller: scrollController,
            builder: mapController.sheetPosition.value <= 0.31
                ? (BuildContext context, ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: InitialContainer(),
                    );
                  }
                : (BuildContext context, ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: DestinationContainer(),
                    );
                  },
          ),
        );
      },
    );
  }
}
