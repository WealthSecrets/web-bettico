import 'package:betticos/features/shares/presentation/getx/contribute_controller.dart';
import 'package:get/get.dart';

class ContributionBindings {
  static void dependencies() {
    Get.put(
      ContributeController(),
      permanent: true,
    );
  }
}
