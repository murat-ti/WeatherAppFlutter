import 'package:json_annotation/json_annotation.dart';

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({required this.id, required this.main, required this.description, required this.icon});
}

class WeatherConverter implements JsonConverter<Weather, Map<String, dynamic>> {
  const WeatherConverter();

  @override
  Weather fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson(Weather temp) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = temp.id;
    data['main'] = temp.main;
    data['description'] = temp.description;
    data['icon'] = temp.icon;
    return data;
  }
}
