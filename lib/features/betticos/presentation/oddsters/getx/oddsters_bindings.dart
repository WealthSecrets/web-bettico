import 'package:betticos/features/betticos/domain/usecases/oddsters/search_oddsters.dart';
import 'package:get/get.dart';

import '/features/betticos/domain/usecases/oddsters/get_all_oddsters.dart';
import '/features/betticos/presentation/oddsters/getx/oddsters_controller.dart';

// class OddstersBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.put<OddstersController>(
//       OddstersController(
//         getAllOddsters: GetAllOddsters(
//           betticosRepository: Get.find(),
//         ),
//         searchAllOddsters: SearchAllOddsters(
//           betticosRepository: Get.find(),
//         ),
//       ),
//       permanent: true,
//     );
//   }
// }

class OddstersBindings {
  static void dependencies() {
    Get.put<OddstersController>(
      OddstersController(
        getAllOddsters: GetAllOddsters(
          betticosRepository: Get.find(),
        ),
        searchAllOddsters: SearchAllOddsters(
          betticosRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
