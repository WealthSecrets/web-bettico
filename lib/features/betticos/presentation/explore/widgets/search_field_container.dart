import 'package:betticos/core/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../getx/explore_controller.dart';

class SearchFieldContainer extends StatefulWidget {
  const SearchFieldContainer({Key? key}) : super(key: key);

  @override
  State<SearchFieldContainer> createState() => _SearchFieldContainerState();
}

class _SearchFieldContainerState extends State<SearchFieldContainer> {
  final ExploreController controller = Get.find<ExploreController>();

  final PublishSubject<String> _subject = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    _subject
        .debounceTime(const Duration(milliseconds: 500))
        .distinctUnique()
        .listen(
      (String term) {
        if (term.isNotEmpty) {
          controller.setSelectedHashtag(term);
          controller.navigateToSearchPage();
          controller.getFilteredPosts(1);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SearchField(
      hintText: 'Search Xviral',
      onChanged: _subject.add,
    );
  }
}
