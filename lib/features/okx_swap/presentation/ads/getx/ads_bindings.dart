import 'package:betticos/features/okx_swap/presentation/ads/getx/ads_controller.dart';
import 'package:get/get.dart';

class AdsBinding {
  static void dependencies() {
    Get.put<AdsController>(
      AdsController(),
      permanent: true,
    );
  }
}
