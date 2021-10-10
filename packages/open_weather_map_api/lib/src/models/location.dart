import 'package:json_annotation/json_annotation.dart';
import 'package:open_weather_map_api/open_weather_map_api.dart';
part 'location.g.dart';

@JsonSerializable()
class Location {
  const Location({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    this.daily,
    this.hourly,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  final double lat;
  final double lon;
  final String timezone;
  @JsonKey(name: 'timezone_offset')
  final int timezoneOffset;
  final List<DailyWeather>? daily;
  final List<HourlyWeather>? hourly;
}