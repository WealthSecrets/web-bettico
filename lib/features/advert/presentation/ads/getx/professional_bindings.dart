import 'package:betticos/features/advert/domain/usecases/create_business.dart';
import 'package:get/get.dart';

import 'professional_controller.dart';

class ProfessionalBindings {
  static void dependencies() {
    Get.put<ProfessionalController>(
      ProfessionalController(createBusiness: CreateBusiness(advertRepository: Get.find())),
      permanent: true,
    );
  }
}
