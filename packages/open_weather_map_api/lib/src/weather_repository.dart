import 'dart:async';
import 'package:open_weather_map_api/open_weather_map_api.dart';
import 'package:open_weather_map_api/src/models/daily_weather.dart';
import 'open_weather_map_api_client.dart';// hide DailyWeather, HourlyWeather;

class WeatherFailure implements Exception {}

class WeatherRepository {
  WeatherRepository({OpenWeatherMapApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? OpenWeatherMapApiClient();

  final OpenWeatherMapApiClient _weatherApiClient;

  /*Future<Location> getDailyWeather(double lat, double lon) async {
    final weather = await _weatherApiClient.getDailyWeather(lat, lon);
    return Location.fromJson(
      lat: weather.lat,
      long: weather.long,
      timezone: weather.timezone,
      timezoneOffset: weather.timezoneOffset,
      daily: weather.daily,
      hourly: weather.hourly
    );
  }*/

  /*Future<DailyWeather> getDailyWeather(double lat, double lon) async {
    final weather = await _weatherApiClient.getDailyWeather(lat, lon);
    return DailyWeather(
      dt: weather.dt,
      sunrise: weather.sunrise,
      sunset: weather.sunset,
      moonrise: weather.moonrise,
      moonset: weather.moonset,
      moonPhase: weather.moonPhase,
      temp: weather.temp,
      feelsLike: weather.feelsLike,
      pressure: weather.pressure,
      humidity: weather.humidity,
      dewPoint: weather.dewPoint,
      windSpeed: weather.windSpeed,
      windDeg: weather.windDeg,
      windGust: weather.windGust,
      weather: weather.weather,
      clouds: weather.clouds,
      pop: weather.pop,
      uvi: weather.uvi,
    );
  }*/
}