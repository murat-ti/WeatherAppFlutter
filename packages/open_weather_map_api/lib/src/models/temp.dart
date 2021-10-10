import 'package:json_annotation/json_annotation.dart';

class Temp {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });
}

class TempConverter implements JsonConverter<Temp, Map<String, dynamic>> {
  const TempConverter();

  @override
  Temp fromJson(Map<String, dynamic> json) {
    return Temp(
      day: json['day'],
      min: json['min'],
      max: json['max'],
      night: json['night'],
      eve: json['eve'],
      morn: json['morn'],
    );
  }

  @override
  Map<String, dynamic> toJson(Temp temp) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = temp.day;
    data['min'] = temp.min;
    data['max'] = temp.max;
    data['night'] = temp.night;
    data['eve'] = temp.eve;
    data['morn'] = temp.morn;
    return data;
  }
}
