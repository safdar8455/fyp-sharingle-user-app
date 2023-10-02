import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';

class SaveLocationTopbar extends StatelessWidget {
  const SaveLocationTopbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            Get.back();
          },
          child: Icon(LineAwesomeIcons.times),
          style: OutlinedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(5.0),
          ),
        ),
        SizedBox(width: 10),
        Text(
          RsSaveLocationTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}