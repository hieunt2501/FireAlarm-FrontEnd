import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences> _sharedPreference;
  static const String is_dark_mode = "is_dark_mode";
  static const String language_code = "language_code";
  static const String user_Token = "user_token";

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  Future<bool> get isLoggedIn {
    return _sharedPreference.then((prefs) {
      var token = prefs.getString(user_Token) ?? null;
      if (token == null) return false;
      return true;
    });
  }

  Future<void> setToken(String token) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(user_Token, 'Bearer ' + token);
    });
  }

  Future<String> get userToken {
    return _sharedPreference.then((prefs) {
      return prefs.getString(user_Token) ?? null;
    });
  }

  // Future<String> getToken() {
  //   return _sharedPreference.then((prefs) {
  //     return prefs.getString(user_Token) ?? null;
  //   });
  // }
  // //Theme module
  // Future<void> changeTheme(bool value) {
  //   return _sharedPreference.then((prefs) {
  //     return prefs.setBool(is_dark_mode, value);
  //   });
  // }

  // Future<bool> get isDarkMode {
  //   return _sharedPreference.then((prefs) {
  //     return prefs.getBool(is_dark_mode) ?? false;
  //   });
  // }

  // //Locale module
  // Future<String> get appLocale {
  //   return _sharedPreference.then((prefs) {
  //     return prefs.getString(language_code) ?? null;
  //   });
  // }

  // Future<void> changeLanguage(String value) {
  //   return _sharedPreference.then((prefs) {
  //     return prefs.setString(language_code, value);
  //   });
  // }
}
