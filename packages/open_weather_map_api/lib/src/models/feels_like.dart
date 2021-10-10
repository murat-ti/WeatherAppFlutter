import 'package:json_annotation/json_annotation.dart';

class FeelsLike {
  final double day;
  final double night;
  final double eve;
  final double morn;

  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });
}

class FeelsLikeConverter implements JsonConverter<FeelsLike, Map<String, dynamic>> {
  const FeelsLikeConverter();

  @override
  FeelsLike fromJson(Map<String, dynamic> json) {
    return FeelsLike(
      day: json['day'],
      night: json['night'],
      eve: json['eve'],
      morn: json['morn'],
    );
  }

  @override
  Map<String, dynamic> toJson(FeelsLike temp) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = temp.day;
    data['night'] = temp.night;
    data['eve'] = temp.eve;
    data['morn'] = temp.morn;
    return data;
  }
}

