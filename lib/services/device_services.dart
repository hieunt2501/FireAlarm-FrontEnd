import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api.dart';

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
    // print(response.body['message']);
    if (response.statusCode == 200) {
      print('Succeed!');
    } else {
      throw Exception('Failed to turn off device!');
    }
  }
}
