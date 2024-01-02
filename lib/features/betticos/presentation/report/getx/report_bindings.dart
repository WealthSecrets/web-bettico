import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';

import 'report_controller.dart';

class ReportBindings {
  static void dependencies() {
    Get.put<ReportController>(
      ReportController(
        addReport: AddReport(betticosRepository: Get.find()),
        getReportOptions: GetReportOptions(betticosRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
