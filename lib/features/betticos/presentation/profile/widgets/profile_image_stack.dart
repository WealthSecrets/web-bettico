import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/features/presentation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:ionicons/ionicons.dart';

class ProfileImageStack extends StatefulWidget {
  const ProfileImageStack({super.key, required this.user});

  final User user;

  @override
  State<ProfileImageStack> createState() => _ProfileImageStackState();
}

class _ProfileImageStackState extends State<ProfileImageStack> {
  final ProfileController controller = Get.find<ProfileController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (controller.profileImage.value.isEmpty)
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=800',
                  // headers: <String, String>{'Authorization': 'Bearer ${bController.userToken.value}'},
                ),
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(image: MemoryImage(controller.profileImage.value), fit: BoxFit.cover),
            ),
          ),
        if (widget.user.id == bController.user.value.id)
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(AppAssetIcons.tick, height: 25, width: 25),
          ),
      ],
    );
  }

  void onPickImage() async {
    Navigator.pop(context);
    final FilePickerResult? picked = await FilePicker.platform.pickFiles(
      type: FileType.image,
      onFileLoading: (FilePickerStatus status) => debugPrint(status.name),
    );

    if (picked != null) {
      final Uint8List? bytes = picked.files.first.bytes;

      controller.onProfileImageSelected(bytes);
      if (!mounted) {
        return;
      }
      controller.updateTheUserProfilePhoto(context);
    }
  }
}

// class _BottomSheet extends StatelessWidget {
//   const _BottomSheet({required this.onPickImage});
//   final VoidCallback onPickImage;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100.0,
//       width: MediaQuery.of(context).size.width,
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Column(
//         children: <Widget>[
//           Text('choose_profile_photo'.tr, style: const TextStyle(fontSize: 20.0)),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               IconButton(icon: const Icon(Ionicons.camera), onPressed: onPickImage),
//               IconButton(icon: const Icon(Ionicons.image), onPressed: onPickImage),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
