import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OddsterSearch extends SearchDelegate<String> {
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  final OddstersController oController = Get.find<OddstersController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      hintColor: Colors.black,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        toolbarTextStyle: const TextStyle(
          fontSize: 16,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: context.colors.textDark,
          fontFamily: AppFonts.base,
        ),
        iconTheme: IconThemeData(
          color: context.colors.primary,
        ),
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _debouncer.run(() {
      if (query.isNotEmpty) {
        oController.searchOddsters(context, query);
      }
    });

    return Obx(() {
      return ListView.separated(
        itemCount: query.isNotEmpty ? oController.userSearchResults.length : oController.oddsters.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListUserRow(
            context,
            query.isNotEmpty ? oController.userSearchResults[index] : oController.oddsters[index],
            () {},
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: context.colors.faintGrey,
        ),
      );
    });
  }

  Widget _buildListUserRow(BuildContext context, User user, Function() onPressed) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ProfileScreen(
                  user: user,
                ),
              ),
            );
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                  '${AppEndpoints.userImages}/${user.photo}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                '@${user.username}',
                style: TextStyle(
                  color: context.colors.text,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }
}
