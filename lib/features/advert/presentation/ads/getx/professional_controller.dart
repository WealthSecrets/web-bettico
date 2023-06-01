import 'package:betticos/features/advert/presentation/ads/utils/business_category_type.dart';
import 'package:get/get.dart';

class ProfessionalController extends GetxController {
  ProfessionalController();

  Rx<BusinessCategoryType> category = BusinessCategoryType.unknown.obs;
}
