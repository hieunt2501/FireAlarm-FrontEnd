import 'package:flutter/material.dart';
import '../utils/routes/routes.dart';

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
      routes: Routes.routes,
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => FireAlarmAppHome(),
      // },
    );
  }
}
