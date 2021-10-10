enum WeatherType {
  daily,
  hourly
}

extension WeatherTypeExtension on WeatherType {
  String get toExcept {
    switch (this) {
      case WeatherType.hourly:
        return 'daily';
      case WeatherType.daily:
      default:
        return 'hourly';
    }
  }

  String get value {
    switch (this) {
      case WeatherType.hourly:
        return 'Hourly';
      case WeatherType.daily:
      default:
        return 'Daily';
    }
  }
}