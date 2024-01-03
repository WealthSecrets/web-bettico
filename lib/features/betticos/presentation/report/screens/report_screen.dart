import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ReportController controller = Get.find<ReportController>();

  final dynamic data = Get.arguments;

  @override
  void initState() {
    if (data != null) {
      controller.getTheReportOptions(context, data.type as String);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ReportArgument? args = ModalRoute.of(context)?.settings.arguments as ReportArgument?;
    if (args != null) {
      controller.setPostId(pId: args.postId);
      controller.setUserId(uId: args.userId);
    }
    return Obx(
      () => AppLoadingBox(
        loading: controller.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Ionicons.close),
              color: context.colors.primary,
              onPressed: () => Get.back<void>(),
            ),
            centerTitle: false,
            title: Text('Report an issue', style: context.h6.copyWith(color: Colors.black)),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: AppPaddings.lH.add(AppPaddings.lV),
                child: Text(
                  '${'problem'.tr} ${args?.type.toLowerCase().tr.toLowerCase()}?',
                  style: context.body1.copyWith(color: context.colors.text),
                ),
              ),
              const AppSpacing(v: 16),
              ...controller.reportOptions.map(
                (ReportOption option) => ListTile(
                  shape: Border(bottom: BorderSide(color: context.colors.text)),
                  title: Text(
                    option.title,
                    style: context.body2.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    controller.setSelectedOption(option);
                    controller.addTheReport(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
