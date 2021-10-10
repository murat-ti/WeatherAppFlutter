import 'package:equatable/equatable.dart';

/*enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  mist,
  smoke,
  haze,
  dust,
  fog,
  sand,
  ash,
  squall,
  tornado,
  clear,
  clouds,
  unknown,
}*/

class Weather extends Equatable {
  const Weather({
    required this.timezone,
    required this.dt,
    required this.temp,
    required this.condition,
  });

  final String timezone;
  final int dt;
  final double temp;
  final String condition;

  @override
  List<Object> get props => [timezone, dt, temp, condition];
}