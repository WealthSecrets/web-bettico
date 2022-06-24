import 'package:betticos/features/betticos/domain/usecases/report/add_report.dart';
import 'package:betticos/features/betticos/domain/usecases/report/get_report_options.dart';
import 'package:betticos/features/betticos/presentation/report/getx/report_controller.dart';
import 'package:get/get.dart';

// class ReportBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.put<ReportController>(
//       ReportController(
//         addReport: AddReport(
//           betticosRepository: Get.find(),
//         ),
//         getReportOptions: GetReportOptions(
//           betticosRepository: Get.find(),
//         ),
//       ),
//       permanent: true,
//     );
//   }
// }

class ReportBindings {
  static void dependencies() {
    Get.put<ReportController>(
      ReportController(
        addReport: AddReport(
          betticosRepository: Get.find(),
        ),
        getReportOptions: GetReportOptions(
          betticosRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
