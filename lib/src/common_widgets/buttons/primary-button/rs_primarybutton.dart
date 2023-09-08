import 'package:flutter/material.dart';
import 'package:sharingle_user_app/src/common_widgets/buttons/widgets/button_loading_widget.dart';

class RsPrimaryButton extends StatelessWidget {
  const RsPrimaryButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final VoidCallback onPress;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPress,
        child: isLoading ? const ButtonLoadingWidget() : Text(text),
      ),
    );
  }
}
