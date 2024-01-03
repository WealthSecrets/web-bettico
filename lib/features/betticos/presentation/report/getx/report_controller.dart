import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:betticos/features/presentation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ReportController extends GetxController {
  ReportController({required this.getReportOptions, required this.addReport});

  final GetReportOptions getReportOptions;
  final AddReport addReport;

  RxList<ReportOption> reportOptions = <ReportOption>[].obs;
  RxString type = 'post'.obs;
  Rx<ReportOption> selectedOption = ReportOption.empty().obs;
  RxString userId = ''.obs;
  RxString postId = ''.obs;
  RxBool isLoading = false.obs;

  void getTheReportOptions(BuildContext context, String typ) async {
    isLoading(true);
    type(typ);
    final Either<Failure, List<ReportOption>> failureOrOptions =
        await getReportOptions(GetReportOptionsRequest(type: typ.trim()));

    failureOrOptions.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<ReportOption> options) {
        isLoading(false);
        reportOptions(options);
      },
    );
  }

  void navigateToAddReport(BuildContext context, String type, {String? postId, String? userId}) async {
    Get.back<void>();
    final dynamic value = await Get.toNamed<dynamic>(
      AppRoutes.report,
      arguments: ReportArgument(type: type, postId: postId, userId: userId),
    );
    if (value != null && context.mounted) {
      await AppSnacks.show(
        context,
        message: 'We have received your report. Thank you.',
        backgroundColor: context.colors.success,
        leadingIcon: const Icon(Ionicons.checkmark_circle_outline, color: Colors.white),
      );
    }
  }

  void addTheReport(BuildContext context) async {
    isLoading(true);

    final Either<Failure, void> failureOrReport = await addReport(
      ReportRequest(
        type: type.value.trim(),
        optionId: selectedOption.value.id,
        userId: type.value == 'post' ? null : userId.value.trim(),
        postId: type.value == 'user' ? null : postId.value.trim(),
      ),
    );

    failureOrReport.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (_) {
        isLoading(false);
        Get.back<dynamic>(result: true);
      },
    );
  }

  void setSelectedOption(ReportOption option) {
    selectedOption(option);
  }

  void setType(String typ) {
    type(typ);
  }

  void setUserId({String? uId}) {
    if (uId == null) {
      userId('');
    } else {
      userId(uId);
    }
  }

  void setPostId({String? pId}) {
    if (pId == null) {
      postId('');
    } else {
      postId(pId);
    }
  }
}
