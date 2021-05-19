import 'package:flutter/foundation.dart';

class Temperature {
  final double temperature;
  final String name;
  final String unit;
  final DateTime time;

  Temperature(
      {@required this.temperature,
      @required this.name,
      @required this.unit,
      @required this.time});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      temperature: double.parse(json['data']),
      name: json['name'],
      unit: json['unit'],
      time: DateTime.parse(json['createAt']),
    );
  }
}
