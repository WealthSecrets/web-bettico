import 'package:betticos/common/common.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

class VerificationLevelsScreen extends StatelessWidget {
  const VerificationLevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: AppPaddings.lH,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) => const LevelCard(),
      ),
    );
  }
}
