import 'package:flutter/material.dart';

enum SpecialCategoryType {
  credit('credit'),
  employment('employment'),
  housing('housing'),
  socialIssues('social issues'),
  election('election'),
  politics('politics'),
  unknown('');

  const SpecialCategoryType(this.rawValue);

  static SpecialCategoryType fromValue(String value) {
    for (final SpecialCategoryType item in values) {
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
