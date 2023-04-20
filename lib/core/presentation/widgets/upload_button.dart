import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import '/core/core.dart';

enum UploadButtonType { files, photos }

class UploadButton extends StatefulWidget {
  const UploadButton({
    Key? key,
    required this.onFileSelected,
    required this.type,
    this.style,
    this.buttonText,
    this.textColor,
    this.openFrontCamera = false,
  }) : super(key: key);

  final Function(Uint8List?) onFileSelected;
  final UploadButtonType type;
  final ButtonStyle? style;
  final String? buttonText;
  final Color? textColor;
  final bool openFrontCamera;

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  Uint8List? selected;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle _style = widget.style ??
        TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.colors.primary.shade100, width: 1),
            borderRadius: AppBorderRadius.smallAll,
          ),
          padding: selected != null ? EdgeInsets.zero : AppPaddings.lH.add(AppPaddings.homeV),
          backgroundColor: context.colors.primary.shade100,
        );

    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.9,
          child: TextButton(
            style: _style,
            onPressed: _onPickFile,
            child: selected == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        widget.type == UploadButtonType.files ? Ionicons.document_outline : Ionicons.camera_outline,
                        color: context.colors.hintLight,
                        size: 40,
                      ),
                      const AppSpacing(v: 8),
                      Text(
                        widget.buttonText ?? 'Take Document Image',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: widget.textColor ?? context.colors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.smallAll,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(selected!),
                      ),
                    ),
                  ),
          ),
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
            child: SizedBox(
              height: 20,
              child: Text(
                'Remove',
                style: TextStyle(
                  fontSize: 12,
                  color: context.colors.text,
                ),
              ),
            ),
          )
        else
          const SizedBox(
            height: 20,
          )
      ],
    );
  }

  void _onPickFile() async {
    final FilePickerResult? picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => debugPrint(status.name),
      allowedExtensions: <String>['png', 'jpg', 'jpeg', 'pdf', 'doc', 'docx'],
    );

    if (picked != null) {
      final Uint8List? bytes = picked.files.first.bytes;

      setState(() {
        selected = bytes;
      });
      widget.onFileSelected(bytes);
    }
  }
}
