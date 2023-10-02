import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';

class SearchPickupResultNotFound extends StatelessWidget {
  const SearchPickupResultNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            RsNoSearchResultFoundTitle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            RsNoSearchResultFoundSubTitle,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Get.back();
              },
              icon: Icon(LineAwesomeIcons.alternate_map_marked),
              label: Text(RsSelectLocationOnMap),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
