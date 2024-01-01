import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/core.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

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
            onPressed: () {},
          ),
          title: Text(
            'payments'.tr,
            style: context.body1.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: Text('payment_screen'.tr),
        ),
      ),
    );
  }
}
