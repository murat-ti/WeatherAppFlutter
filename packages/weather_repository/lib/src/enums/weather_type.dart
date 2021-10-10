enum WeatherType {
  daily,
  hourly
}

extension on WeatherType {
  String get toType {
    switch (this) {
      case WeatherType.hourly:
        return 'daily';
      case WeatherType.daily:
      default:
        return 'hourly';
    }
  }
}