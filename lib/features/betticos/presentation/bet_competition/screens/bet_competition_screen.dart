// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BetCompetitionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          automaticallyImplyLeading: false,
          leading: IconButton(icon: const Icon(Icons.menu, color: Colors.black), onPressed: () {}),
          title: Text('bet_comp'.tr, style: context.body1.copyWith(color: Colors.black)),
        ),
        body: Center(child: Text('bet_comp_screen'.tr)),
      ),
    );
  }
}
