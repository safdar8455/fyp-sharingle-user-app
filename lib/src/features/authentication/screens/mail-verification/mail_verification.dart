import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sharingle_user_app/src/constants/sizes.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';
import 'package:sharingle_user_app/src/features/authentication/controllers/mail_verification_controller.dart';
import 'package:sharingle_user_app/src/repository/authentication_repository/authentication_repository.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.put(MailVerificationController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: RsDefaultSize * 5,
            left: RsDefaultSize,
            right: RsDefaultSize,
            bottom: RsDefaultSize * 2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LineAwesomeIcons.envelope_open, size: 100),
              const SizedBox(height: RsDefaultSize * 2),
              Text(RsEmailVerificationTitle, style: textTheme.headlineMedium),
              const SizedBox(height: RsDefaultSize),
              Text(RsEmailVerificationSubTitle,
                  style: textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: RsDefaultSize * 2),
              SizedBox(
                width: 200,
                child: OutlinedButton(
                    onPressed: () =>
                        controller.manuallyCheckEmailVerificationStatus(),
                    child: Text(RsContinue.tr)),
              ),
              const SizedBox(height: RsDefaultSize * 2),
              TextButton(
                  onPressed: () => controller.sendVerificationEmail(),
                  child: Text(RsResendEmail.tr)),
              TextButton(
                onPressed: () => AuthenticationRepository.instance.logout(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LineAwesomeIcons.alternate_long_arrow_left),
                    const SizedBox(width: 5),
                    Text(RsBackToLogin.tr.toLowerCase()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
