import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/common_widgets/form/form_header_widget.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';

class ForgetPasswordPhoneScreen extends StatelessWidget {
  const ForgetPasswordPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(RsDefaultSize),
            child: Column(
              children: [
                SizedBox(height: RsDefaultSize),
                FormHeaderWidget(
                  applogoImage: isDarkMode ? RsAppLogoDark : RsAppLogoLight,
                  image: RsForgetPasswordImage,
                  title: RsForgetPassword,
                  subTitle: RsForgetPhoneSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBeteen: RsDefaultSize,
                  imageHeight: 0.3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: RsFormHeight),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(RsPhoneNo),
                          hintText: RsPhoneNo,
                          prefixIcon: Icon(Icons.numbers),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(RsNext.toUpperCase()),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
