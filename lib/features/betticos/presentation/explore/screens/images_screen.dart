import 'package:betticos/common/common.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesScreen extends StatelessWidget {
  ImagesScreen({super.key});

  final ExploreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);

    return Scaffold(
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isSearching.value,
          child: controller.images.isEmpty && !controller.isSearching.value
              ? AppEmptyScreen(message: 'Oops! No results found for ${controller.selectedHashtag.value}')
              : ListView.builder(
                  padding: isSmallScreen ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero,
                  itemCount: controller.images.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Post post = controller.images[index];
                    return TimelineCard(
                      post: post,
                      onTap: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(builder: (BuildContext context) => PostDetailsScreen(post: post)),
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
