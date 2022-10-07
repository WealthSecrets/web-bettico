import 'package:betticos/core/presentation/web_controllers/menu_controller.dart';
import 'package:get/get.dart';

class MenuBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<MenuController>(
      MenuController(),
      permanent: true,
    );
  }
}
