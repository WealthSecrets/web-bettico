import 'package:betticos/features/advert/domain/usecases/create_advert.dart';
import 'package:get/get.dart';

import 'ads_controller.dart';

class AdsBinding {
  static void dependencies() {
    Get.put<AdsController>(
      AdsController(createAdvert: CreateAdvert(advertRepository: Get.find())),
      permanent: true,
    );
  }
}
