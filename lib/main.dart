import 'dart:async';

import 'package:flutter/material.dart';

import 'fire_alarm_home.dart';
import './pages/fire_detected_screen.dart';
import './api.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  //  Connect Firebase
  await Firebase.initializeApp();
  FirebaseMessaging.instance.onTokenRefresh.listen((event) {
    print('New token is generated!');
    String token = event.toString();
    print(token);
    token = token.toString();
    APIS().sendTokenToServer(token);
  });
  await FirebaseMessaging.instance.getToken().then((value){
        print('#####################################################');
        print(value);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
