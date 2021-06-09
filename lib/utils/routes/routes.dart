import 'package:firealarm/ui/login_signup/login_screen.dart';
import 'package:firealarm/ui/login_signup/sign_up_screen.dart';
import 'package:firealarm/ui/profile/my_profile.dart';
import 'package:firealarm/ui/resource-screen/resource_screen.dart';
import 'package:flutter/material.dart';
import '../../ui/home_screen/home_screen.dart';
import '../../ui/profile/profile.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String resource = '/resource';

  static final routes = <String, WidgetBuilder>{
    // splash: (BuildContext context) => SplashScreen(),
    signup: (BuildContext context) => SignupScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    profile: (BuildContext context) => MyProfileScreen(),
    resource: (BuildContext context) => ResourceScreen(),
  };
}
