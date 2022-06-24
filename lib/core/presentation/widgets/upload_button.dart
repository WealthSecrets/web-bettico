import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  final Function(File?) onFileSelected;
  final UploadButtonType type;
  final ButtonStyle? style;
  final String? buttonText;
  final Color? textColor;
  final bool openFrontCamera;

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  File? selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.9,
          child: TextButton(
            style: widget.style ??
                TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: context.colors.primary.shade100, width: 1),
                    borderRadius: AppBorderRadius.smallAll,
                  ),
                  padding: selected != null
                      ? EdgeInsets.zero
                      : AppPaddings.lH.add(AppPaddings.homeV),
                  backgroundColor: context.colors.primary.shade100,
                ),
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();

              final XFile? image = await _picker.pickImage(
                // source: widget.type == UploadButtonType.files ? ImageSource.gallery : ImageSource.camera,
                source: ImageSource.camera,
                maxWidth: 1500,
                maxHeight: 1500,
                preferredCameraDevice: widget.openFrontCamera
                    ? CameraDevice.front
                    : CameraDevice.rear,
              );
              if (image != null) {
                setState(() {
                  selected = File(image.path);
                });
                widget.onFileSelected(File(image.path));
              }
            },
            child: selected == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        widget.type == UploadButtonType.files
                            ? Ionicons.document_outline
                            : Ionicons.camera_outline,
                        color: context.colors.hintLight,
                        size: 40,
                      ),
                      const AppSpacing(v: 8),
                      Text(
                        widget.buttonText ?? 'Take Document Image',
                        textAlign: TextAlign.center,
                        style: context.caption.copyWith(
                          color: widget.textColor ?? context.colors.text,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.smallAll,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                          selected!,
                        ),
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
                style: context.caption,
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
}
