import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import '../../services/monitor_services.dart';
import 'package:firealarm/models/temperature.dart';
import '../../utils/helper_function/helper_function.dart';
import 'monitor_base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool get wantKeepAlive => false;

  // simutaneously call fetch data every 5 seconds
  // void setUpTimedFetch() {
  //   Timer.periodic(Duration(seconds: 5), (timer) {
  //     setState(() {
  //       _temperatureData = MonitorAPIs.fetchTemperature("0", "30");
  //     });
  //   });
  // }

  void fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("user_token");
    setState(() {
      _temperatureData = MonitorAPIs.fetchTemperature("0", "30", token);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([_temperatureData]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              processData(snapshot.data[0]);
              return BaseMonitorScreen(
                  temperatureData: this.temperatureList,
                  labelData: this.labelList,
                  getTitle: getTitle,
                  dataProp: this.dataProp);
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
    print(this.labelList);
    return this.labelList[value.toInt()] + 'h';
  }

  // process data when successfully get data
  void processData(List<Temperature> tempData) {
    double maxTemp = 0;

    HashMap tempMap = new HashMap<String, List<double>>();
    temperatureList = [];
    labelList = [];

    double temp;
    double sum = 0;

    for (int i = 0; i < tempData.length; i++) {
      temp = tempData[i].temperature;
      String hour = tempData[i].time.hour.toString();

      if (tempMap.containsKey(hour)) {
        tempMap[hour].insert(0, temp);
      } else {
        if (tempMap.length == 10) break;
        tempMap[hour] = new List<double>();
        tempMap[hour].insert(0, temp);
        this.labelList.insert(0, hour);
      }
    }

    for (int i = 0; i < this.labelList.length; i++) {
      List<double> tmp = tempMap[labelList[i]];
      double avg = tmp.reduce((a, b) => a + b) / tmp.length;
      print(tmp.reduce((a, b) => a + b));
      print("Length: " + tmp.length.toString());
      // print(avg);
      if (maxTemp < avg) maxTemp = avg;
      sum += avg;
      this.temperatureList.insert(0, HelperFunction.roundDouble(avg, 2));
    }

    this.dataProp['maxTemp'] = HelperFunction.roundDouble(maxTemp, 2);
    this.dataProp['minTemp'] =
        this.temperatureList.reduce((a, b) => a > b ? b : a);
    this.dataProp['maxLength'] = this.temperatureList.length.toDouble();
    this.dataProp['avgTemp'] =
        HelperFunction.roundDouble(sum / this.temperatureList.length, 2);

    // print(this.temperatureList);
  }
}
