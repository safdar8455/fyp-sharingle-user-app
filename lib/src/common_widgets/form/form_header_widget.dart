import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    required this.applogoImage,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageHeight = 0.2,
    this.heightBeteen,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  final String applogoImage, image, title, subTitle;

  final double? heightBeteen;
  final double imageHeight;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage(applogoImage),
              height: size.height * 0.03,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage(image),
              height: size.height * imageHeight,
            ),
          ),
        ),
        SizedBox(height: heightBeteen),
        Text(title, style: Theme.of(context).textTheme.displayLarge),
        Text(subTitle,
            textAlign: textAlign, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
