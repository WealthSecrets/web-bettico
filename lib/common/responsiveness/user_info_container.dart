import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoContainer extends StatelessWidget {
  UserInfoContainer({super.key});
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPaddings.lH.add(AppPaddings.mV),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: context.colors.faintGrey),
        borderRadius: AppBorderRadius.largeAll,
      ),
      child: Row(
        children: <Widget>[
          Obx(
            () => GestureDetector(
              onTap: () {
                menuController.changeActiveItemTo(AppRoutes.profile);
                if (ResponsiveWidget.isSmallScreen(context)) {
                  Get.back<void>();
                }
                navigationController.navigateTo(
                  AppRoutes.profile,
                  arguments: ProfileScreenArgument(user: bController.user.value),
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${AppEndpoints.userImages}/${bController.user.value.photo ?? 'default.jpg'}',
                      headers: <String, String>{'Authorization': 'Bearer ${bController.userToken.value}'},
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Obx(
            () => Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Text(
                        '${bController.user.value.firstName} ${bController.user.value.lastName}',
                        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(width: 5),
                      if (bController.user.value.role == 'admin')
                        Image.asset(AssetImages.verified, height: 14, width: 14),
                    ],
                  ),
                  Text(
                    '@${bController.user.value.username}',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: context.colors.text),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              showAppModal<void>(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: SizedBox(
                      width: 600,
                      height: 500,
                      child: ClipRRect(borderRadius: AppBorderRadius.mediumAll, child: const TimelinePostScreen()),
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 30,
              padding: AppPaddings.lH.add(AppPaddings.mV),
              decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(15)),
              child: const Center(
                child: Text('Post', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
