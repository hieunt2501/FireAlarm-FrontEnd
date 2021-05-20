import 'package:flutter/foundation.dart';

class Gas {
  final double concentration;
  final String name;
  final String unit;
  final DateTime time;

  Gas(
      {@required this.concentration,
      @required this.name,
      @required this.unit,
      @required this.time});

  factory Gas.fromJson(Map<String, dynamic> json) {
    return Gas(
      concentration: double.parse(json['data']),
      name: json['name'],
      unit: json['unit'],
      time: DateTime.parse(json['createAt']),
    );
  }
}
