import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/features/core/models/save-location/save_location_model.dart';
import 'package:sharingle_user_app/src/features/core/screens/save-location/widgets/save_location_card_widget.dart';
import 'package:sharingle_user_app/src/features/core/screens/save-location/widgets/save_location_form_widet.dart';
import 'package:sharingle_user_app/src/features/core/screens/save-location/widgets/save_location_topbar_widget.dart';

class SaveLocationScreen extends StatelessWidget {
  const SaveLocationScreen({super.key, required this.locationModel});

  final SaveLocationModel locationModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top Tittle With Back Button
                SaveLocationTopbar(),
                SizedBox(height: RsDefaultSize),

                // Location Container
                SaveLocationCard(locationModel: locationModel),
                SizedBox(height: RsDefaultSize),

                // Save Location Information Container
                SaveLocationFrom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
