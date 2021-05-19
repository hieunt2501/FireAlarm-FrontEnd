import 'dart:async';

import 'package:flutter/material.dart';
import 'fire_alarm_home.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget _defaultHome;
  bool _result = true;

  if (_result) {
    _defaultHome = FireAlarmAppHome();
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FIRE ALARM",
      theme: new ThemeData(
        primaryColor: Colors.blueGrey[900],
        // accentColor: Colors.brown[100],
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => FireAlarmAppHome(),
      },
    );
  }
}
