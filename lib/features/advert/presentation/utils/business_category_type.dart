import 'package:flutter/material.dart';

enum BusinessCategoryType {
  artist('artist'),
  musician(r'musician\band'),
  blogger('blogger'),
  clothing('clothing brand'),
  community('community'),
  digitalcreator('digital creator'),
  education('education'),
  entrepreneur('entrepreneur'),
  contentcreator('content creator'),
  unknown('');

  const BusinessCategoryType(this.rawValue);

  static BusinessCategoryType fromValue(String value) {
    for (final BusinessCategoryType item in values) {
      if (item.rawValue == value.toLowerCase()) {
        return item;
      }
    }
    return unknown;
  }

  String get displayName {
    if (this == unknown) {
      return rawValue;
    }

    return rawValue.splitMapJoin(
      ' ',
      onMatch: (_) => ' ',
      onNonMatch: (String value) => value[0].toUpperCase() + value.substring(1).toLowerCase(),
    );
  }

  @visibleForTesting
  final String rawValue;
}
