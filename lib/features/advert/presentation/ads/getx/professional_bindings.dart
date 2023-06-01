import 'package:get/get.dart';

import 'professional_controller.dart';

class ProfessionalBindings {
  static void dependencies() {
    Get.put<ProfessionalController>(
      ProfessionalController(),
      permanent: true,
    );
  }
}
