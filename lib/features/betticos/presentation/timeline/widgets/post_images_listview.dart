import 'package:betticos/common/common.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class PostImagesListview extends StatelessWidget {
  PostImagesListview({super.key});

  final TimelineController timelineController = Get.find<TimelineController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 175.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: timelineController.files.length,
          itemBuilder: (BuildContext context, int index) => Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => FullImage(image: timelineController.files[index]),
                    ),
                  );
                },
                child: Container(
                  height: 170,
                  width: 150,
                  margin: AppPaddings.lL,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: MemoryImage(timelineController.files[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: GestureDetector(
                  child: const Icon(Ionicons.close_circle_sharp, color: Colors.red, size: 20),
                  onTap: () => timelineController.removeImage(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
