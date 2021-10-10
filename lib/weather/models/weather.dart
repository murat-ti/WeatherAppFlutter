import 'package:equatable/equatable.dart';
import 'package:weather_repository/weather_repository.dart' as weather_repository;

class Weather extends Equatable {
  const Weather({
    required this.timezone,
    required this.dt,
    required this.temp,
    required this.condition,
  });

  factory Weather.fromRepository(weather_repository.Weather weather) {
    return Weather(
      timezone: weather.timezone,
      dt: weather.dt,
      temp: weather.temp,
      condition: weather.condition,
    );
  }

  static List<Weather> fromRepositoryList(List<weather_repository.Weather> weatherList) {
    return weatherList.map((item) => Weather.fromRepository(item)).toList();
  }

  static const empty = Weather(
    timezone: 'unknown',
    dt: 0,
    temp: 0.00,
    condition: 'unknown',
  );

  final String timezone;
  final int dt;
  final double temp;
  final String condition;

  @override
  List<Object> get props => [timezone, dt, temp, condition];

  Weather copyWith({
    String? timezone,
    int? dt,
    double? temp,
    String? condition,
  }) {
    return Weather(
      timezone: timezone ?? this.timezone,
      dt: dt ?? this.dt,
      temp: temp ?? this.temp,
      condition: condition ?? this.condition,
    );
  }
}
