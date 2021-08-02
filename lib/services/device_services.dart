// import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../constants/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceAPIs {
  DeviceAPIs._();

  static Future<void> turnOnDevice(String deviceID) async {
    var response = await http.post(
        Uri.https(APIs.baseResourceUrl, APIs.turnOnDeviceRoute,
            {"roomDeviceId": deviceID}),
        headers: {"Authorization": APIs.userToken});
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Succeed!');
    } else {
      throw Exception('Failed to turn on device!');
    }
  }

  static Future<void> turnOffDevice(String deviceID) async {
    var response = await http.post(
        Uri.https(APIs.baseResourceUrl, APIs.turnOffDeviceRoute,
            {"roomDeviceId": deviceID}),
        headers: {"Authorization": APIs.userToken});
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Succeed!');
    } else {
      throw Exception('Failed to turn off device!');
    }
  }

  static Future<bool> checkDevice(String deviceID) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("user_token");
    var response = await http.get(
        Uri.https(APIs.baseResourceUrl, APIs.myDevices),
        headers: {"Authorization": token});
    if (response.statusCode == 200) {
      print('Succeed!');
    } else {
      throw Exception('Failed to fetch device information!');
    }
    var data = jsonDecode(response.body)["data"];
    for (final e in data){
      if (deviceID == e["id"].toString()){
        if (e["status"] == "On"){
          return true;
        }
        if (e["status"] == "Off"){
          return false;
        }
      }
    }
    return false;
  }
}
