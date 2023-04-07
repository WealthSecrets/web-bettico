import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_response_data.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponseData<T> {
  const PaginatedResponseData({
    required this.data,
    required this.currentPage,
    required this.total,
    required this.itemsPerPage,
    required this.isLastPage,
    this.nextUrl,
    this.previousUrl,
    this.nextPage,
    this.previousPage,
  });

  factory PaginatedResponseData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$PaginatedResponseDataFromJson<T>(json, fromJsonT);
  }

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$PaginatedResponseDataToJson(this, toJsonT);

  @JsonKey(name: 'currentPage')
  final int currentPage;

  @JsonKey(name: 'data')
  final List<T> data;

  @JsonKey(name: 'previousUrl')
  final String? previousUrl;

  @JsonKey(name: 'nextUrl')
  final String? nextUrl;

  @JsonKey(name: 'itemsPerPage')
  final int itemsPerPage;

  @JsonKey(name: 'isLastPage')
  final bool isLastPage;

  final int total;
  final int? previousPage;
  final int? nextPage;

// ignore: long-parameter-list
  PaginatedResponseData<T> copyWith({
    int? currentPage,
    List<T>? data,
    bool? isLastPage,
    String? nextUrl,
    String? previousUrl,
    int? itemsPerPage,
    int? total,
    int? nextPage,
    int? previousPage,
  }) {
    return PaginatedResponseData<T>(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
      nextUrl: nextUrl ?? this.nextUrl,
      previousUrl: previousUrl ?? this.previousUrl,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      total: total ?? this.total,
      nextPage: nextPage ?? this.nextPage,
      previousPage: previousPage ?? this.previousPage,
    );
  }

  @override
  String toString() {
    return 'PaginatedResponseData(currentPage: $currentPage, data: $data, isLastPage: $isLastPage, nextUrl: $nextUrl, previousUrl: $previousUrl, itemsPerPage: $itemsPerPage, nextPage: $nextPage, total: $total, previousPage: $previousPage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is PaginatedResponseData<T> &&
        other.currentPage == currentPage &&
        listEquals(other.data, data) &&
        other.nextUrl == nextUrl &&
        other.previousUrl == previousUrl &&
        other.total == total &&
        other.nextPage == nextPage &&
        other.previousPage == previousPage;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        data.hashCode ^
        nextUrl.hashCode ^
        previousUrl.hashCode ^
        total.hashCode ^
        nextPage.hashCode ^
        previousPage.hashCode;
  }
}
