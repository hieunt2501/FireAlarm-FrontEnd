import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import '../../services/monitor_services.dart';
import 'package:firealarm/models/temperature.dart';
import 'monitor_base_screen.dart';

class MonthlyScreen extends StatefulWidget {
  MonthlyScreen();

  @override
  _MonthlyScreenState createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends State<MonthlyScreen>
    with AutomaticKeepAliveClientMixin<MonthlyScreen> {
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
        _temperatureData = MonitorAPIs.fetchTemperature();
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
    return this.labelList[value.toInt()] + 'h';
  }

  // process data when successfully get data
  void processData(List<Temperature> tempData) {
    double maxTemp = 0;
    double maxLength = tempData.length.toDouble();
    temperatureList = [];
    labelList = [];

    var temp;
    double sum = 0;

    for (int i = 0; i < tempData.length; i++) {
      temp = tempData[i].temperature;
      if (maxTemp < temp) maxTemp = temp;
      sum += temp;
      this.temperatureList.insert(0, temp);
      this.labelList.insert(0, tempData[i].time.hour.toString());
    }

    this.dataProp['maxTemp'] = maxTemp;
    this.dataProp['maxLength'] = maxLength;
    this.dataProp['avgTemp'] = sum / tempData.length;
  }
}
