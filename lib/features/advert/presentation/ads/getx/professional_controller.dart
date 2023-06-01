import 'package:betticos/features/advert/presentation/ads/utils/business_category_type.dart';
import 'package:get/get.dart';

enum BusinessType { creator, business }

class ProfessionalController extends GetxController {
  ProfessionalController();

  Rx<BusinessCategoryType> category = BusinessCategoryType.unknown.obs;
  Rx<BusinessType> businessType = BusinessType.creator.obs;

  RxBool isUpdatingBusinessType = false.obs;

  bool get isBusinessCategoryValid => category.value != BusinessCategoryType.unknown;
}
