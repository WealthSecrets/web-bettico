import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import '/core/core.dart';

class CreateShareScreen extends StatelessWidget {
  const CreateShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add New Shares'.tr, style: const TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: Obx(() {
        return Padding(
          padding: AppPaddings.lH,
          child: AppAnimatedColumn(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const AppSpacing(v: 20),
              AppTextInput(
                labelText: 'Share Price'.toUpperCase(),
                backgroundColor: context.colors.primary.shade100,
                lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                validator: (String input) => null,
                onChanged: (String value) {},
              ),
              const AppSpacing(v: 8),
              AppTextInput(
                labelText: 'No. of Contributors'.toUpperCase(),
                backgroundColor: context.colors.primary.shade100,
                lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                validator: (String input) => null,
                onChanged: (String value) {},
              ),
              const AppSpacing(v: 8),
              AppTextInput(
                labelText: 'Duration'.toUpperCase(),
                backgroundColor: context.colors.primary.shade100,
                lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                validator: (String input) => null,
                onChanged: (String value) {},
              ),
              const AppSpacing(v: 49),
              AppButton(
                borderRadius: AppBorderRadius.largeAll,
                onPressed: () {},
                child: Text(
                  'Create Shares'.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              const AppSpacing(v: 50),
            ],
          ),
        );
      }),
    );
  }
}
