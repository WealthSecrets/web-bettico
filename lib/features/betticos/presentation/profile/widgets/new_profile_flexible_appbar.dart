import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewProfileFlexibleAppBar extends StatefulWidget {
  const NewProfileFlexibleAppBar({super.key, required this.user, this.showBackButton});
  final User user;
  final bool? showBackButton;

  @override
  State<NewProfileFlexibleAppBar> createState() => _ProfileFlexibleAppBarState();
}

class _ProfileFlexibleAppBarState extends State<NewProfileFlexibleAppBar> {
  final ProfileController controller = Get.find<ProfileController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Padding(
        padding: AppPaddings.lB,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 138,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AssetImages.topbar), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Row(
                children: <Widget>[
                  ProfileImageStack(user: widget.user),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${widget.user.firstName} ${widget.user.lastName}',
                        style: TextStyle(color: context.colors.black, fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      if (widget.user.createdAt != null)
                        Text(
                          'Joined since ${AppDateUtils.format(widget.user.createdAt!)}',
                          style: TextStyle(color: context.colors.darkenText, fontWeight: FontWeight.w300, fontSize: 12),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const AppSpacing(v: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Motion and graphics designer. I sometimes write javascript for fun.',
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF3A424A),
                ),
              ),
            ),
            const AppSpacing(v: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Image.asset(AppAssetIcons.link, height: 15, width: 15),
                  const SizedBox(width: 8),
                  Text(
                    'blankson.xviral.io',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.1,
                      fontWeight: FontWeight.w300,
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: AppPaddings.lH,
              child: Row(
                children: <Widget>[
                  _RowTextButton(count: widget.user.following?.toString(), title: 'Following'),
                  const SizedBox(width: 12),
                  _RowTextButton(count: widget.user.following?.toString(), title: 'Following'),
                ],
              ),
            ),
            //
            const AppSpacing(v: 16),
            Padding(
              padding: AppPaddings.lH,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ProfileButton(
                    onPressed: () {},
                    child: Image.asset(AppAssetIcons.inboxOut, height: 25, width: 25, color: context.colors.primary),
                  ),
                  const AppSpacing(h: 10),
                  ProfileButton(
                    padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 56),
                    onPressed: () {},
                    child: Text(
                      'Follow',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                  const AppSpacing(h: 10),
                  ProfileButton(
                    onPressed: () {},
                    child: Image.asset(AppAssetIcons.star, height: 25, width: 25, color: context.colors.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _ButtonsRow extends StatelessWidget {
//   _ButtonsRow({required this.user});

//   final User user;

//   final ProfileController controller = Get.find<ProfileController>();
//   final BaseScreenController bController = Get.find<BaseScreenController>();
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Padding(
//         padding: AppPaddings.lH,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             if (user.id == bController.user.value.id)
//               OutlinedButton(
//                 onPressed: () => _handleEditProfile(context),
//                 style: OutlinedButton.styleFrom(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
//                   side: BorderSide(width: 2.0, color: context.colors.cardColor),
//                 ),
//                 child: Text(
//                   'edit_profile'.tr,
//                   style: TextStyle(color: context.colors.textDark, fontWeight: FontWeight.bold, fontSize: 12),
//                 ),
//               ),
//             if (user.id != bController.user.value.id)
//               OutlinedButton(
//                 onPressed: () {
//                   if (controller.isFollowedByUser.value) {
//                     controller.unfollowTheUser();
//                   } else {
//                     controller.followTheUser();
//                   }
//                 },
//                 style: OutlinedButton.styleFrom(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
//                   backgroundColor: controller.isFollowedByUser.value ? context.colors.primary : Colors.white,
//                   side: BorderSide(
//                     width: 2.0,
//                     color: controller.isFollowedByUser.value ? context.colors.primary : context.colors.cardColor,
//                   ),
//                 ),
//                 child: controller.isFollowingUser.value || controller.isUnfollowingUser.value
//                     ? SizedBox(
//                         height: 10,
//                         width: 10,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: controller.isUnfollowingUser.value ? Colors.white : context.colors.primary,
//                         ),
//                       )
//                     : Text(
//                         controller.isFollowedByUser.value ? 'following'.tr : 'follow'.tr,
//                         style: TextStyle(
//                           color: controller.isFollowedByUser.value ? Colors.white : context.colors.textDark,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//               ),
//             if (user.id != bController.user.value.id && (user.role == 'oddster'))
//               OutlinedButton(
//                 onPressed: () => controller.subscribeToTheUser(context, user.id),
//                 style: OutlinedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25.0),
//                   ),
//                   backgroundColor: controller.isSubscribedToUser.value ? context.colors.error : Colors.white,
//                   side: BorderSide(
//                     width: 2.0,
//                     color: controller.isSubscribedToUser.value ? context.colors.error : context.colors.cardColor,
//                   ),
//                 ),
//                 child: controller.isSubscribingToUser.value
//                     ? SizedBox(
//                         height: 10,
//                         width: 10,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: controller.isSubscribedToUser.value ? Colors.white : context.colors.error,
//                         ),
//                       )
//                     : Text(
//                         controller.isSubscribedToUser.value ? 'subscribed'.tr : 'subscribe'.tr,
//                         style: TextStyle(
//                           color: controller.isSubscribedToUser.value ? Colors.white : context.colors.textDark,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _handleEditProfile(BuildContext context) async {
//     final dynamic value = await Navigator.push<dynamic>(
//       context,
//       MaterialPageRoute<dynamic>(builder: (BuildContext context) => UpdateProfileScreen(user: user)),
//     );

//     if (value == true && context.mounted) {
//       await AppSnacks.show(
//         context,
//         message: 'Profile updated successfully',
//         backgroundColor: context.colors.success,
//         leadingIcon: const Icon(Ionicons.checkmark_circle_outline, color: Colors.white),
//       );
//     }
//   }
// }

class _RowTextButton extends StatelessWidget {
  const _RowTextButton({this.count, required this.title});

  final String? count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          count ?? '0',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.2,
            color: context.colors.black,
          ),
        ),
        const SizedBox(width: 3),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0.2,
            color: context.colors.icon,
          ),
        ),
      ],
    );
  }
}

// class _ProfileNameSection extends StatelessWidget {
//   const _ProfileNameSection({required this.user});

//   final User user;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               '${user.firstName} ${user.lastName}',
//               style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
//             ),
//             const AppSpacing(h: 5),
//             if (user.role == 'admin') Image.asset(AssetImages.verified, height: 14, width: 14),
//           ],
//         ),
//         Text(
//           '@${user.username}',
//           style: TextStyle(color: context.colors.text, fontSize: 12),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
// }
