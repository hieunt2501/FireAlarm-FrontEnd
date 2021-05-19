import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../api_list.dart';
import 'package:firealarm/models/temperature.dart';
import '../pages/monitor_base_screen.dart';

class DailyScreen extends StatefulWidget {
  DailyScreen();

  @override
  _DailyScreenState createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen>
    with AutomaticKeepAliveClientMixin<DailyScreen> {
  Future<List<Temperature>> _temperatureData; // temperature data list
  HashMap dataProp = new HashMap<String, double>(); // data props for passing
  HashMap dailyData = new HashMap<String, List<double>>();
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
  String getTitle(List<dynamic> data, double value) {
    return (data[value.toInt()].time.hour).toString() + 'h';
  }

  // process data when successfully get data
  void processData(List<Temperature> data) {
    double maxTemp = 0;
    List<String> dayList = [];
    this.temperatureList = [];
    this.labelList = [];
    // double maxLength = data.length.toDouble();

    var temp;
    String day = '';
    // double sum = 0;
    for (int i = 0; i < data.length; i++) {
      temp = data[i].temperature;
      day = data[i].time.hour.toString();

      if (!this.dailyData.containsKey(day)) {
        this.dailyData[day] = [];
        dayList.add(day);
      } else {
        this.dailyData[day].add(temp);
      }
    }

    print(day);

    for (int i = 0; i < dayList.length; i++) {
      temp =
          this.dailyData[this.labelList[i]].fold(0, (prev, cur) => prev + cur);
      if (maxTemp < temp) maxTemp = temp;
      this.temperatureList.insert(0, temp);
      this.labelList.insert(0, dayList[i]);
    }
    // print(this.dailyData)
    // this.dataProp['maxTemp'] = maxTemp;
    // this.dataProp['maxLength'] = maxLength;
    // this.dataProp['avgTemp'] = sum / data.length;
  }
}
