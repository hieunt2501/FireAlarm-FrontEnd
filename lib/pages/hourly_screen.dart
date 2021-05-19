import 'dart:async';
import 'dart:collection';
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

class _HourlyScreenState extends State<HourlyScreen>
    with AutomaticKeepAliveClientMixin<HourlyScreen> {
  Future<List<Temperature>> _temperatureData; // temperature data list
  HashMap dataProp = new HashMap<String, double>(); // data props for passing
  List<String> labelList;
  List<double> temperatureList;

  // boolean to keep state alive
  bool get wantKeepAlive => true;

  // fetch temperature data from API
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

  // simutaneously call fetch data every 5 seconds
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
    setUpTimedFetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        child: FutureBuilder<List<Temperature>>(
          future: _temperatureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              processData(snapshot.data);
              return MonitorBaseScreen(
                  temperatureData: this.temperatureList,
                  labelData: this.labelList,
                  getTitle: getTitle,
                  dataProp: this.dataProp);
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
      ),
    );
  }

  // callback for setting chart x bar
  String getTitle(double value) {
    return this.labelList[value.toInt()] + 'h';
  }

  // process data when successfully get data
  void processData(List<Temperature> data) {
    double maxTemp = 0;
    double maxLength = data.length.toDouble();
    temperatureList = [];
    labelList = [];

    var temp;
    double sum = 0;

    for (int i = 0; i < data.length; i++) {
      temp = data[i].temperature;
      if (maxTemp < temp) maxTemp = temp;
      sum += temp;
      this.temperatureList.insert(0, temp);
      this.labelList.insert(0, data[i].time.hour.toString());
    }

    this.dataProp['maxTemp'] = maxTemp;
    this.dataProp['maxLength'] = maxLength;
    this.dataProp['avgTemp'] = sum / data.length;
  }
}
