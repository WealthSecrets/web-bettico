// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'time.freezed.dart';
part 'time.g.dart';

@freezed
class Time with _$Time {
  const factory Time({
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'starting_at') required StartTime startingAt,
    @JsonKey(name: 'minute') int? minute,
    @JsonKey(name: 'second') String? second,
  }) = _Time;

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  factory Time.empty() => Time(
        startingAt: StartTime.empty(),
      );
}

@freezed
class StartTime with _$StartTime {
  const factory StartTime({
    @JsonKey(name: 'date_time') required String dateTime,
    @JsonKey(name: 'date') required String date,
    @JsonKey(name: 'time') required String time,
    @JsonKey(name: 'timestamp') int? timeStamp,
    @JsonKey(name: 'timezone') required String timezone,
  }) = _StartTime;

  factory StartTime.fromJson(Map<String, dynamic> json) => _$StartTimeFromJson(json);

  factory StartTime.empty() => const StartTime(date: '', dateTime: '', time: '', timezone: '');
}
