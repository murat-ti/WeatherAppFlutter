// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'daily_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyWeather _$DailyWeatherFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DailyWeather',
      json,
      ($checkedConvert) {
        final val = DailyWeather(
          dt: $checkedConvert('dt', (v) => v as int),
          sunrise: $checkedConvert('sunrise', (v) => v as int),
          sunset: $checkedConvert('sunset', (v) => v as int),
          moonrise: $checkedConvert('moonrise', (v) => v as int),
          moonset: $checkedConvert('moonset', (v) => v as int),
          moonPhase:
              $checkedConvert('moon_phase', (v) => (v as num).toDouble()),
          temp: $checkedConvert('temp',
              (v) => const TempConverter().fromJson(v as Map<String, dynamic>)),
          feelsLike: $checkedConvert(
              'feels_like',
              (v) => const FeelsLikeConverter()
                  .fromJson(v as Map<String, dynamic>)),
          pressure: $checkedConvert('pressure', (v) => v as int),
          humidity: $checkedConvert('humidity', (v) => v as int),
          dewPoint: $checkedConvert('dew_point', (v) => (v as num).toDouble()),
          windSpeed:
              $checkedConvert('wind_speed', (v) => (v as num).toDouble()),
          windDeg: $checkedConvert('wind_deg', (v) => v as int),
          windGust: $checkedConvert('wind_gust', (v) => (v as num).toDouble()),
          weather: $checkedConvert(
              'weather',
              (v) => (v as List<dynamic>)
                  .map((e) => const WeatherConverter()
                      .fromJson(e as Map<String, dynamic>))
                  .toList()),
          clouds: $checkedConvert('clouds', (v) => v as int),
          pop: $checkedConvert('pop', (v) => v as int),
          uvi: $checkedConvert('uvi', (v) => (v as num).toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {
        'moonPhase': 'moon_phase',
        'feelsLike': 'feels_like',
        'dewPoint': 'dew_point',
        'windSpeed': 'wind_speed',
        'windDeg': 'wind_deg',
        'windGust': 'wind_gust'
      },
    );
