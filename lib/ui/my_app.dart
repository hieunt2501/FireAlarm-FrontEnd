import 'package:firealarm/ui/smoke_detection/smoke_detected_screen.dart';
import 'package:flutter/material.dart';
import '../utils/routes/routes.dart';

import './home_screen/home_screen.dart';

import './fire_detection/fire_detected_screen.dart'; // for testing only
<<<<<<< HEAD
import './smoke_detection/smoke_detected_screen.dart';
import 'login/login_screen.dart'; // for testing only
=======
import './smoke_detection/smoke_detected_screen.dart'; // for testing only
>>>>>>> 4a92c4986443f5505db3c5029b17c40e823053b9

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
<<<<<<< HEAD
      home: LoginScreen(),
=======
      home: HomeScreen(),
>>>>>>> 4a92c4986443f5505db3c5029b17c40e823053b9
    );
  }
}
