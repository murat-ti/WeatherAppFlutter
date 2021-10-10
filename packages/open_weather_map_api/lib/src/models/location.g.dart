// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Location',
      json,
      ($checkedConvert) {
        final val = Location(
          lat: $checkedConvert('lat', (v) => (v as num).toDouble()),
          lon: $checkedConvert('lon', (v) => (v as num).toDouble()),
          timezone: $checkedConvert('timezone', (v) => v as String),
          timezoneOffset: $checkedConvert('timezone_offset', (v) => v as int),
          daily: $checkedConvert(
              'daily',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => DailyWeather.fromJson(e as Map<String, dynamic>))
                  .toList()),
          hourly: $checkedConvert(
              'hourly',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => HourlyWeather.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'timezoneOffset': 'timezone_offset'},
    );
