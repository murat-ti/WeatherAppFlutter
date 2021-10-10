// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'hourly_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyWeather _$HourlyWeatherFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HourlyWeather',
      json,
      ($checkedConvert) {
        final val = HourlyWeather(
          dt: $checkedConvert('dt', (v) => v as int),
          temp: $checkedConvert('temp', (v) => (v as num).toDouble()),
          feelsLike:
              $checkedConvert('feels_like', (v) => (v as num).toDouble()),
          pressure: $checkedConvert('pressure', (v) => v as int),
          humidity: $checkedConvert('humidity', (v) => v as int),
          dewPoint: $checkedConvert('dew_point', (v) => (v as num).toDouble()),
          uvi: $checkedConvert('uvi', (v) => (v as num).toDouble()),
          clouds: $checkedConvert('clouds', (v) => v as int),
          visibility: $checkedConvert('visibility', (v) => v as int),
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
          pop: $checkedConvert('pop', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'feelsLike': 'feels_like',
        'dewPoint': 'dew_point',
        'windSpeed': 'wind_speed',
        'windDeg': 'wind_deg',
        'windGust': 'wind_gust'
      },
    );
