import 'dart:async';
import 'package:open_weather_map_api/open_weather_map_api.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart';
import 'enums/weather_type.dart';

class WeatherFailure implements Exception {}

class WeatherRepository {
  WeatherRepository({OpenWeatherMapApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? OpenWeatherMapApiClient();

  final OpenWeatherMapApiClient _weatherApiClient;

  Future<List<Weather>> getDailyWeather(double lat, double lon, [String type = 'hourly']) async {
    final weather = await _weatherApiClient.getDailyWeather(lat, lon, type);
    List<Weather> result = [];
    String timezone = weather.timezone;

    if (weather.daily != null && weather.daily is List) {
      weather.daily!
          .map(
            (item) => result.add(
              Weather(
                timezone: timezone,
                dt: item.dt,
                temp: item.temp.day,
                condition: item.weather.first.main,
              ),
            ),
          ).toList();
    } else if (weather.hourly != null && weather.hourly is List) {
      weather.hourly!
          .map(
            (item) => result.add(
          Weather(
            timezone: timezone,
            dt: item.dt,
            temp: item.temp,
            condition: item.weather.first.main,
          ),
        ),
      ).toList();
    }

    return result;
  }
}

/*
extension on WeatherState {
  WeatherCondition get toCondition {
    switch (this) {
      case WeatherState.clear:
        return WeatherCondition.clear;
      case WeatherState.snow:
      case WeatherState.sleet:
      case WeatherState.hail:
        return WeatherCondition.snowy;
      case WeatherState.thunderstorm:
      case WeatherState.heavyRain:
      case WeatherState.lightRain:
      case WeatherState.showers:
        return WeatherCondition.rainy;
      case WeatherState.heavyCloud:
      case WeatherState.lightCloud:
        return WeatherCondition.cloudy;
      default:
        return WeatherCondition.unknown;
    }
  }
}*/
