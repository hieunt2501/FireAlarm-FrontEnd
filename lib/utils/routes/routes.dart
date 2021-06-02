import 'package:firealarm/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import '../../ui/home_screen/home_screen.dart';
import '../../ui/profile/profile.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';

  static final routes = <String, WidgetBuilder>{
    // splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    profile: (BuildContext context) => ProfileScreen(),
  };
}
