import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterwhatsapp/fire_alarm_home.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "FIRE",
      theme: new ThemeData(
        primaryColor: Colors.blueGrey[900],
        // accentColor: Colors.brown[100],
      ),
      debugShowCheckedModeBanner: false,
      home: new FireAlaramAppHome(),
    );
  }
}
