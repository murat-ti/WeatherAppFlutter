import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../open_weather_map_api.dart';
import 'models/enums/weather_type.dart';

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

/// {@template open_weather_map_api_client}
/// Dart API Client which wraps the [MetaWeather API](https://www.metaweather.com/api/).
/// {@endtemplate}
class OpenWeatherMapApiClient {
  /// {@macro open_weather_map_api_client}
  OpenWeatherMapApiClient({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'api.openweathermap.org';
  static const _appId = '7542f68142d6be5f7b70b36ba8bd799c';
  final http.Client _httpClient;

  Future<Location> getDailyWeather(double lat, double lon, [String type = 'hourly']) async {
    final weatherRequest =
    Uri.https(_baseUrl, '/data/2.5/onecall', {
      'appid': _appId,
      'lat': '$lat',
      'lon': '$lon',
      'exclude': 'current,minutely,alerts,${type}',
      'units': 'metric',
    });

    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;
    if (bodyJson.isEmpty) {
      throw WeatherNotFoundFailure();
    }

    // ignore: unnecessary_cast
    return Location.fromJson(bodyJson as Map<String, dynamic>);
  }
}