import 'dart:async';
import 'dart:collection';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../services/monitor_services.dart';
import 'package:firealarm/models/temperature.dart';
import 'monitor_base_screen.dart';
import '../../utils/helper_function/helper_function.dart';

class MinutelyScreen extends StatefulWidget {
  MinutelyScreen();

  @override
  _MinutelyScreenState createState() => _MinutelyScreenState();
}

class _MinutelyScreenState extends State<MinutelyScreen>
    with AutomaticKeepAliveClientMixin<MinutelyScreen> {
  Future<List<Temperature>> _temperatureData; // temperature data list

  HashMap dataProp = new HashMap<String, double>(); // data props for passing
  List<String> labelList;
  List<double> temperatureList;

  // boolean to keep state alive
  bool get wantKeepAlive => true;

  // simutaneously call fetch data every 5 seconds
  void setUpTimedFetch() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _temperatureData = MonitorAPIs.fetchTemperature("0", "10");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // setUpTimedFetch();
    // _temperatureData = MonitorAPIs.fetchTemperature("0", "10");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _temperatureData = MonitorAPIs.fetchTemperature("0", "10");
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
    return this.labelList[value.toInt()];
  }

  // process data when successfully get data
  void processData(List<Temperature> tempData) {
    double maxTemp = 0;
    double minTemp = tempData[0].temperature;
    double maxLength = tempData.length.toDouble();
    temperatureList = [];
    labelList = [];

    var temp;
    double sum = 0;

    for (int i = 0; i < tempData.length; i++) {
      temp = tempData[i].temperature;
      if (maxTemp < temp) maxTemp = temp;
      if (minTemp > temp) minTemp = temp;
      sum += temp;
      String hour = tempData[i].time.hour.toString();
      String minute = tempData[i].time.minute.toString();
      this.temperatureList.insert(0, HelperFunction.roundDouble(temp, 2));
      this.labelList.insert(0, hour + 'h' + minute);
    }

    this.dataProp['maxTemp'] = maxTemp;
    this.dataProp['minTemp'] = minTemp;
    this.dataProp['maxLength'] = maxLength;
    this.dataProp['avgTemp'] =
        HelperFunction.roundDouble(sum / tempData.length, 2);
  }
}
