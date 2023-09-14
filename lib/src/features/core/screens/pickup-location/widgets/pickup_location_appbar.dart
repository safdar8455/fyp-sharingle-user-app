import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/features/core/screens/profile/profile_screen.dart';

class PickupLocationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PickupLocationAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: AppBar(
        leading: OutlinedButton(
          onPressed: () => Get.to(() => const ProfileScreen()),
          child: Icon(Icons.menu),
          style: OutlinedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.all(5.0),
            shape: CircleBorder(),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          OutlinedButton(
            onPressed: () => Get.back(),
            child: Icon(Icons.close),
            style: OutlinedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.all(5.0),
              shape: CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
