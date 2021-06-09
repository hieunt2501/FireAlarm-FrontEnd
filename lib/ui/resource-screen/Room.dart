import 'package:flutter/foundation.dart';

class Room {
  String name;
  String description;

  Room({@required this.name, @required this.description});

  factory Room.fromJson(Map json) {
    return Room(name: json['name'], description: json['description']);
  }

  Map toJson() {
    return {'name': name, 'description': description};
  }
}
