import 'package:betticos/features/betticos/presentation/private_sales/getx/sales_controller.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/transaction/get_user_stats.dart';
import 'package:get/get.dart';

class SalesBindings {
  static void dependencies() {
    Get.lazyPut(
      () => SalesController(
        getUserStats: GetUserStats(p2prepository: Get.find()),
      ),
    );
  }
}
