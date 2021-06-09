import 'package:firealarm/caches/sharedpref/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api.dart';
import 'dart:convert';
// import '../services/auth_services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../models/user.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  // Registering
}
/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, the Splash Screen will be shown
- Authenticated - User is authenticated successfully, Home Page will be shown
- Authenticating - Sign In button just been pressed, progress bar will be shown
- Unauthenticated - User is not authenticated, login page will be shown
- Registering - User just pressed registering, progress bar will be shown

Take note, this is just an idea. You can remove or further add more different
status for your UI or widgets to listen.
 */

class AuthProvider extends ChangeNotifier {
  SharedPreferenceHelper _sharedPrefsHelper;
  SharedPreferences _sharedPreferences;
  Status _status = Status.Uninitialized;

  AuthProvider() {
    // setup();
    _sharedPrefsHelper = SharedPreferenceHelper();
    _sharedPrefsHelper.userToken.then((token) {
      if (token != null) {
        _status = Status.Authenticated;
        notifyListeners();
      }
    });
  }

  // setup() async {
  //   _sharedPreferences = await SharedPreferences.getInstance();
  //   String token = _sharedPreferences.getString('auth_token') ?? null;
  //   if (token != null) {
  //     _status = Status.Authenticated;
  //     notifyListeners();
  //   }
  // }

  Status get status {
    return _status;
  }

  Future<bool> signUp(
    String email,
    String password,
    String confirm,
    String phoneNumber,
    String address,
  ) async {
    var payload = {
      "email": email,
      "password": password,
      "confirmPassword": confirm,
      "phoneNumber": phoneNumber,
      "address": address
    };
    var url =
        Uri.https(APIs.baseAuthenticationUrl, "/api/authentication/register");
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(payload));
    print('____________________________________');
    print(response.statusCode);
    print(response.body);
    return response.statusCode == 200;
  }

  Future<bool> signIn(String email, String password) async {
    _status = Status.Authenticating;
    var payload = {"email": email, "password": password};
    var url =
        Uri.https(APIs.baseAuthenticationUrl, "/api/authentication/login");
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(payload));
    print('____________________________________');

    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      _status = Status.Authenticated;
      var token = data['data']['accessToken'];
      _sharedPrefsHelper.setToken(token);
      _sharedPrefsHelper.setFireDetected(false);
      _sharedPrefsHelper.setSmokeDetected(false);
      // _sharedPreferences.setString('auth_token', token);
      notifyListeners();
      return true;
    } else {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
