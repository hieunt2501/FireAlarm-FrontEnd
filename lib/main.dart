import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'fire_alarm_home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> sendTokenToServer(String token) async {
  final String userToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJuaGFuQGVtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL21vYmlsZXBob25lIjoiMDEyMyIsIm5iZiI6MTYyMTUyMDIwNiwiZXhwIjoxNjIyMDM4NjA2LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo1MDAxIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NTAwMSJ9.UsfW5NTXc1dwhOJgqHRG7F3NzaCWyaM1iXRhes4vdfY";
  var url = Uri.parse('https://resourceservermultiproject.azurewebsites.net/api/account/updateFirebaseToken');
  
  var body = jsonEncode({
    'firebaseToken': token
  });

  var response = await http.patch(
      url, 
      headers: {
        "Content-Type"  : "application/json",
        "Accept-Encoding" : "gzip, deflate, br",
        "Connection" : "keep-alive",
        "Authorization" : userToken
      },
      body: body);

  print(response.statusCode);
  print(response.body);
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
    sendTokenToServer(token);
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
