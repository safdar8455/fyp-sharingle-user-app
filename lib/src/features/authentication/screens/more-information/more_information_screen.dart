import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/common_widgets/form/form_header_widget.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/more-information/widgets/more_infomation_form.dart';

class MoreInfoScreen extends StatelessWidget {
  const MoreInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(RsDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHeaderWidget(
                  applogoImage: isDarkMode ? RsAppLogoDark : RsAppLogoLight,
                  image: isDarkMode
                      ? RsWelcomeDarkScreenImage
                      : RsWelcomeLightScreenImage,
                  title: RsMoreInfoTitle,
                  subTitle: RsMoreInfoSubTitle,
                ),
                MoreInfoFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
