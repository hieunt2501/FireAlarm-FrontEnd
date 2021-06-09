import 'package:flutter/material.dart';

class User {
  // String uid;
  String email;
  // String displayName;
  String phoneNumber;
  // String photoUrl;

  User({
    @required this.email,
    @required this.phoneNumber,
  });

  factory User.fromJson(Map json) {
    return User(email: json['email'], phoneNumber: json['phone']);
  }
}
