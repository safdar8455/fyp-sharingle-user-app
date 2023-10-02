import 'package:get/get.dart';

class SaveLocationController extends GetxController {
  SaveLocationController get instance => Get.find();

  final RxBool isClickAddOtherDetail = false.obs;
  final RxBool isLocationNameEmpty = true.obs;
  
}
