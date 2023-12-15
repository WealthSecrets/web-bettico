import 'package:betticos/features/shares/presentation/getx/shares_controller.dart';
import 'package:get/get.dart';

class SharesBinding {
  static void dependencies() {
    Get.put(
      SharesController(),
      permanent: true,
    );
  }
}
