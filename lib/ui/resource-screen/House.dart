import 'package:flutter/foundation.dart';

class House {
  int id;
  String name;
  String address;

  House({this.id = 0, @required this.name, @required this.address});

  factory House.fromJson(Map json) {
    return House(id: json['id'], name: json['name'], address: json['address']);
  }
}
