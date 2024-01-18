import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum UploadButtonType { files, photos }

class UploadButton extends StatefulWidget {
  const UploadButton({
    super.key,
    required this.onFileSelected,
    required this.type,
    this.style,
    this.buttonText,
    this.textColor,
    this.openFrontCamera = false,
  });

  final Function(Uint8List?) onFileSelected;
  final UploadButtonType type;
  final ButtonStyle? style;
  final String? buttonText;
  final Color? textColor;
  final bool openFrontCamera;

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  Uint8List? selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton(
          onPressed: _onPickFile,
          child: selected == null
              ? _StackImage(image: AssetImage(AssetImages.profileFrame))
              : _StackImage(image: MemoryImage(selected!)),
        ),
        const AppSpacing(v: 10),
        if (selected != null)
          InkWell(
            onTap: () {
              setState(() {
                selected = null;
                widget.onFileSelected(null);
              });
            },
            child:
                SizedBox(height: 20, child: Text('Remove', style: TextStyle(fontSize: 12, color: context.colors.text))),
          )
        else
          const SizedBox(height: 20)
      ],
    );
  }

  void _onPickFile() async {
    final FilePickerResult? picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      onFileLoading: (FilePickerStatus status) => debugPrint(status.name),
      allowedExtensions: <String>['png', 'jpg', 'jpeg', 'pdf', 'doc', 'docx'],
    );

    if (picked != null) {
      final Uint8List? bytes = picked.files.first.bytes;

      setState(() => selected = bytes);
      widget.onFileSelected(bytes);
    }
  }
}

class _StackImage extends StatelessWidget {
  const _StackImage({required this.image});

  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Stack(
        children: <Widget>[
          Container(
            height: 207,
            width: 207,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              image: DecorationImage(image: image, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(AppAssetIcons.addition, height: 66, width: 66),
          )
        ],
      ),
    );
  }
}
