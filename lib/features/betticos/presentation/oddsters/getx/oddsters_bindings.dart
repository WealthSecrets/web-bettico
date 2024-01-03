import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';

import 'oddsters_controller.dart';

class OddstersBindings {
  static void dependencies() {
    Get.put<OddstersController>(
      OddstersController(
        getAllOddsters: GetAllOddsters(betticosRepository: Get.find()),
        searchAllOddsters: SearchAllOddsters(betticosRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
