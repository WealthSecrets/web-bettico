import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/utils/app_endpoints.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/members/getx/members_controller.dart';
import 'package:betticos/features/betticos/presentation/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';

// TODO: create controller specific for oddbox
class MembersScreen extends KFDrawerContent {
  MembersScreen({Key? key}) : super(key: key);

  static const String route = '/members';

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final MembersController controller = Get.find<MembersController>();

  @override
  void initState() {
    WidgetUtils.onWidgetDidBuild(() {
      controller.loadAllMyMembers(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: ResponsiveWidget.isSmallScreen(context) ? 0.5 : 0,
            automaticallyImplyLeading: ResponsiveWidget.isSmallScreen(context) ? false : true,
            leading: ResponsiveWidget.isSmallScreen(context)
                ? IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: widget.onMenuPressed,
                  )
                : null,
            title: Text(
              'members'.tr,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          body: (controller.myMembers.isEmpty)
              ? AppEmptyScreen(message: 'no_members'.tr)
              : ListView.separated(
                  padding: AppPaddings.lA,
                  itemCount: controller.myMembers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildListUserRow(
                      context,
                      controller.myMembers[index],
                      () => null,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                ),
        ),
      ),
    );
  }

  Widget _buildListUserRow(BuildContext context, User user, Function() onPressed) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ProfileScreen(
                  user: user,
                ),
              ),
            );
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                  '${AppEndpoints.userImages}/${user.photo}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '@${user.username}',
                style: TextStyle(
                  fontSize: 12,
                  color: context.colors.grey,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'follow'.tr,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
