import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';

import 'referral_controller.dart';

class ReferralBindings {
  static void dependencies() {
    Get.put<ReferralController>(
      ReferralController(
        referUser: ReferUser(betticosRepository: Get.find()),
        getReferralCode: GetReferralCode(betticosRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
