import 'package:flutter/material.dart';

class User {
  // String uid;
  String email;
  // String displayName;
  String phoneNumber;
  // String photoUrl;
  int houseNum;
  int deviceNum;
  int roomNum;
  User(
      {@required this.email,
      @required this.phoneNumber,
      @required this.houseNum,
      @required this.deviceNum,
      @required this.roomNum});

  factory User.fromJson(Map json) {
    return User(
        email: json['data']['email'],
        phoneNumber: json['data']['phone'],
        houseNum: json['data']['numberOfHouses'],
        deviceNum: json['data']['numberOfDevices'],
        roomNum: json['data']['numberOfRooms']);
  }
}
