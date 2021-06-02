<<<<<<< HEAD
import 'package:firealarm/ui/login/login_screen.dart';
=======
>>>>>>> 4a92c4986443f5505db3c5029b17c40e823053b9
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
<<<<<<< HEAD
    login: (BuildContext context) => LoginScreen(),
=======
    // login: (BuildContext context) => LoginScreen(),
>>>>>>> 4a92c4986443f5505db3c5029b17c40e823053b9
    home: (BuildContext context) => HomeScreen(),
    profile: (BuildContext context) => ProfileScreen(),
  };
}
