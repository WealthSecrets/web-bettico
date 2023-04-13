import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);

  final ExploreController controller = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isSearching.value,
        child: controller.users.isEmpty
            ? AppEmptyScreen(
                message:
                    'Oops! No results found for ${controller.selectedHashtag.value}')
            : ListView.separated(
                padding: AppPaddings.lA,
                itemCount: controller.users.length,
                itemBuilder: (BuildContext context, int index) {
                  final User user = controller.users[index];
                  return UserCard(user: user);
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: context.colors.faintGrey,
                ),
              ),
      ),
    );
  }
}
