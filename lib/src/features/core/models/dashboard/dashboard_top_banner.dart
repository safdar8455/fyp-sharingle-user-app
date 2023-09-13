import 'package:sharingle_user_app/src/constants/image_strings.dart';

class TopBanner {
  final int id;
  final String bannerImage;

  TopBanner(
    this.id,
    this.bannerImage,
  );

  static List<TopBanner> list = [
    TopBanner(1, RsBanner01),
    TopBanner(2, RsBanner02),
    TopBanner(3, RsBanner03),
    TopBanner(4, RsBanner04),
    TopBanner(5, RsBanner05),
  ];
}
