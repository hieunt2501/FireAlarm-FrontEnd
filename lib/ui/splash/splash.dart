import 'dart:async';

// import 'package:boilerplate/constants/assets.dart';
// import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:firealarm/caches/sharedpref/shared_preference_helper.dart';

import '../../utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Image.asset(
          "lib/icon/alarm-icon.png",
        ),
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // SharedPreferenceHelper sharedPref = SharedPreferenceHelper();
    SharedPreferenceHelper _sharedPrefsHelper = SharedPreferenceHelper();

    Future.delayed(Duration(seconds: 5), () {
      // 5s over, navigate to a new page
    });

    _sharedPrefsHelper.isLoggedIn.then((value) {
      if (value) {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.login);
      }
    });
    // if (sharedPref.isLoggedIn) {
    //   Navigator.of(context).pushReplacementNamed(Routes.home);
    // } else {
    //   Navigator.of(context).pushReplacementNamed(Routes.login);
    // }
    // sharedPref.userToken.then((value) => null)
  }
}
