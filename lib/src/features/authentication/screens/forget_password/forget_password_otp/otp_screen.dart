import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/constants/colors.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharingle_user_app/src/features/authentication/controllers/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({
    super.key,
    required this.verificationField,
  });

  final String verificationField;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var otpController = Get.put(OTPController());
    var otp;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(RsDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  RsOtpTitle,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 80.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  RsOtpSubTitle.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 30.0),
                Text(
                  "$RsOtpMessage  $verificationField",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                OtpTextField(
                  numberOfFields: 6,
                  fillColor: Colors.black.withOpacity(0.2),
                  filled: true,
                  focusedBorderColor: secondaryColor,
                  enabledBorderColor: secondaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                  showFieldAsBox: true,
                  onSubmit: (code) {
                    otp = code;
                    OTPController.instance.verifyOTP(otp);
                  },
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      OTPController.instance.verifyOTP(otp);
                    },
                    child: Text(RsNext.toUpperCase()),
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
