import 'package:equatable/equatable.dart';
import 'package:weather/weather/models/weather.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

class WeatherState extends Equatable {
  WeatherState({
    this.status = WeatherStatus.initial,
    List<Weather>? weather,
  }) : weather = weather ?? [Weather.empty];

  final WeatherStatus status;
  final List<Weather> weather;

  WeatherState copyWith({
    WeatherStatus? status,
    List<Weather>? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [status, weather];
}

/*class WeatherState extends Equatable {
  WeatherState({
    this.status = WeatherStatus.initial,
    List<Weather>? weather,
  }) : weather = weather ?? [Weather.empty];

  final WeatherStatus status;
  final List<Weather> weather;

  WeatherState copyWith({
    WeatherStatus? status,
    List<Weather>? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [status, weather];
}*/
