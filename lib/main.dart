import 'dart:async';
import 'package:firealarm/providers/auth_provider.dart';
import 'package:firealarm/providers/drawer_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import './ui/my_app.dart';
import './services/firebase_services.dart';

// Firebase background handling
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

// #region Connect Firebase
  await Firebase.initializeApp();
  FirebaseMessaging.instance.onTokenRefresh.listen((event) {
    print('New token is generated!');
    String token = event.toString();
    print(token);
    token = token.toString();
    FirebaseAPIs.sendTokenToServer(token);
  });

  await FirebaseMessaging.instance.getToken().then((value) {
    print('#####################################################');
    print(value);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// #endregion

  // runApp(new MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<DrawerProvider>(
          create: (conntext) => DrawerProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}
