import 'package:json_annotation/json_annotation.dart';
import 'temp.dart';
import 'feels_like.dart';
import 'weather.dart';

part 'daily_weather.g.dart';

@JsonSerializable()
class DailyWeather {
  final int dt;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  @JsonKey(name: 'moon_phase')
  final double moonPhase;
  @TempConverter()
  final Temp temp;
  @JsonKey(name: 'feels_like')
  @FeelsLikeConverter()
  final FeelsLike feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  @JsonKey(name: 'wind_speed')
  final double windSpeed;
  @JsonKey(name: 'wind_deg')
  final int windDeg;
  @JsonKey(name: 'wind_gust')
  final double windGust;
  @WeatherConverter()
  final List<Weather> weather;
  final int clouds;
  final int pop;
  final double uvi;

  factory DailyWeather.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherFromJson(json);

  List<DailyWeather> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((item) => _$DailyWeatherFromJson(item)).toList();
  }

  DailyWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.uvi
  });
}