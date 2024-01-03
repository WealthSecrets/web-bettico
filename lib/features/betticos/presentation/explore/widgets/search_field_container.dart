import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rxdart/rxdart.dart';

class SearchFieldContainer extends StatefulWidget {
  const SearchFieldContainer({super.key});

  @override
  State<SearchFieldContainer> createState() => _SearchFieldContainerState();
}

class _SearchFieldContainerState extends State<SearchFieldContainer> {
  final ExploreController controller = Get.find<ExploreController>();

  final PublishSubject<String> _subject = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    _subject.debounceTime(const Duration(milliseconds: 500)).listen(
      (String term) {
        controller.textEditingController.value.text = term;
        if (term.isNotEmpty) {
          controller.setSelectedHashtag(term);
          controller.navigateToSearchPage();
          controller.getFilteredPosts(1);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SearchField(
          controller: controller.textEditingController.value,
          hintText: 'Search Xviral',
          onChanged: _subject.add,
          suffixIcon: IconButton(
            onPressed: () {
              controller.textEditingController.value.text = '';
              if (controller.isOnSearchPage.value) {
                controller.selectedHashtag.value = '';
                controller.isOnSearchPage.value = false;
                navigationController.goBack();
              }
            },
            icon: const Icon(Ionicons.close_circle_sharp, size: 20),
          ),
        );
      },
    );
  }
}
