import 'package:betticos/features/betticos/domain/usecases/referral/get_refer_code.dart';
import 'package:get/get.dart';

import '/features/betticos/domain/usecases/referral/refer_user.dart';
import '/features/betticos/presentation/referral/getx/referral_controller.dart';

class ReferralBindings {
  static void dependencies() {
    Get.put<ReferralController>(
      ReferralController(
        referUser: ReferUser(
          betticosRepository: Get.find(),
        ),
        getReferralCode: GetReferralCode(
          betticosRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
