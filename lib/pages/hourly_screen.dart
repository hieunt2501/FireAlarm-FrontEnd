import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../api_list.dart';
import 'package:firealarm/models/temperature.dart';
import '../pages/monitor_base_screen.dart';

class HourlyScreen extends StatefulWidget {
  HourlyScreen();

  @override
  _HourlyScreenState createState() => _HourlyScreenState();
}

class _HourlyScreenState extends State<HourlyScreen> {
  Future<List<Temperature>> _temperatureData;

  Future<List<Temperature>> fetchTemperature() async {
    var response = await http.get(
        Uri.https(APIS.baseResourceUrl, APIS.deviceLogs, {"roomDeviceId": "7"}),
        headers: {"Authorization": APIS.userToken});

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["data"];

      List<Temperature> result =
          body.map((dynamic item) => Temperature.fromJson(item)).toList();

      return result;
    } else {
      throw Exception('Failed to load temperature data');
    }
  }

  void setUpTimedFetch() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _temperatureData = fetchTemperature();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // init temperature list
    setUpTimedFetch();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        child: FutureBuilder<List<Temperature>>(
          future: _temperatureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MonitorBaseScreen(temperatureData: snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 30,
                width: 30,
              ),
            );
          },
        ),
        // child: MonitorBaseScreen(),
      ),
    );
  }
}
