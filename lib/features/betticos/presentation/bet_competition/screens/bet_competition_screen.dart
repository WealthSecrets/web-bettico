// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';

class BetCompetitionScreen extends KFDrawerContent {
  BetCompetitionScreen({Key? key}) : super(key: key);
  @override
  State<BetCompetitionScreen> createState() => _BetCompetitionScreenState();
}

class _BetCompetitionScreenState extends State<BetCompetitionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: widget.onMenuPressed,
          ),
          title: Text(
            'bet_comp'.tr,
            style: context.body1.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: Text(
            'bet_comp_screen'.tr,
          ),
        ),
      ),
    );
  }
}
