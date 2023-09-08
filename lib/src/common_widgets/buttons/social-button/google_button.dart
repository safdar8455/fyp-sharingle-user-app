import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/common_widgets/buttons/widgets/button_loading_widget.dart';
import 'package:sharingle_user_app/src/constants/image_strings.dart';
import 'package:sharingle_user_app/src/constants/text_strings.dart';

class RsGoogleButton extends StatelessWidget {
  const RsGoogleButton({
    Key? key,
    required this.onPress,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback onPress;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPress,
        icon: isLoading
            ? const SizedBox()
            : Image(
                image: AssetImage(RsGoogleLogoImage),
                width: 24,
                height: 24,
              ),
        label: isLoading
            ? const ButtonLoadingWidget()
            : Text(RsGoogle.toUpperCase()),
      ),
    );
  }
}
