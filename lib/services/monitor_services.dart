import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firealarm/models/temperature.dart';
import '../constants/api.dart';

class MonitorAPIs {
  MonitorAPIs._();

  static Future<List<Temperature>> fetchTemperature() async {
    var response = await http.get(
        Uri.https(APIs.baseResourceUrl, APIs.deviceLogs, {"roomDeviceId": "7"}),
        headers: {"Authorization": APIs.userToken});

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["data"];

      List<Temperature> result =
          body.map((dynamic item) => Temperature.fromJson(item)).toList();
      print('Temperature: ${result[0].temperature}');
      print('Name: ${result[0].name}');
      print('Unit: ${result[0].unit}');
      print('Time: ${result[0].time}');
      print('');
      return result;
    } else {
      throw Exception('Failed to load data');
      // return [];
    }
  }
}
