import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/utils/app_endpoints.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/betticos/presentation/profile/getx/profile_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProfileImageStack extends StatefulWidget {
  const ProfileImageStack({super.key, this.user});

  final User? user;

  @override
  State<ProfileImageStack> createState() => _ProfileImageStackState();
}

class _ProfileImageStackState extends State<ProfileImageStack> {
  final ProfileController controller = Get.find<ProfileController>();

  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    String image = '${AppEndpoints.userImages}/${bController.user.value.photo}';

    if (widget.user != null) {
      image = '${AppEndpoints.userImages}/${widget.user!.photo}';
    }
    return Stack(
      children: <Widget>[
        if (controller.profileImage.value.isEmpty)
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              image: DecorationImage(
                image: NetworkImage(
                  image,
                  headers: <String, String>{'Authorization': 'Bearer ${bController.userToken.value}'},
                ),
                fit: BoxFit.cover,
              ),
              border: Border.all(width: 3, color: context.colors.primary),
              boxShadow: const <BoxShadow>[BoxShadow(blurRadius: 3, color: Colors.black12, offset: Offset(0, 3))],
            ),
          )
        else
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              image: DecorationImage(image: MemoryImage(controller.profileImage.value), fit: BoxFit.cover),
            ),
          ),
        if (widget.user == null)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: context.colors.primary,
                boxShadow: const <BoxShadow>[BoxShadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 3))],
              ),
              child: Center(
                child: GestureDetector(
                  child: const Icon(Ionicons.camera_sharp, color: Colors.white, size: 14),
                  onTap: () => showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) => _BottomSheet(onPickImage: onPickImage),
                  ),
                ),
              ),
            ),
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

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({required this.onPickImage});
  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text('choose_profile_photo'.tr, style: const TextStyle(fontSize: 20.0)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(icon: const Icon(Ionicons.camera), onPressed: onPickImage),
              IconButton(icon: const Icon(Ionicons.image), onPressed: onPickImage),
            ],
          )
        ],
      ),
    );
  }
}
