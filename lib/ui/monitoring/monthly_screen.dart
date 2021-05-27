import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:firealarm/models/gas.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../constants/api.dart';
import 'package:firealarm/models/temperature.dart';
import './monitor_base_screen.dart';

class MonthlyScreen extends StatefulWidget {
  MonthlyScreen();

  @override
  _MonthlyScreenState createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends State<MonthlyScreen>
    with AutomaticKeepAliveClientMixin<MonthlyScreen> {
  Future<List<Temperature>> _temperatureData; // temperature data list
  Future<List<Gas>> _gasData; // gas data list

  HashMap dataProp = new HashMap<String, double>(); // data props for passing
  List<String> labelList;
  List<double> temperatureList;
  List<double> gasList;

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
      throw Exception('Failed to load data');
    }
  }

  Future<List<Gas>> fetchGas() async {
    var response = await http.get(
        Uri.https(APIS.baseResourceUrl, APIS.deviceLogs,
            {"roomDeviceId": "23", "numberOfRecord": "10"}),
        headers: {"Authorization": APIS.userToken});

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["data"];

      List<Gas> result =
          body.map((dynamic item) => Gas.fromJson(item)).toList();

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
        _gasData = fetchGas();
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
        child: FutureBuilder(
          future: Future.wait([_temperatureData, _gasData]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              processData(snapshot.data[0], snapshot.data[1]);
              return MonitorBaseScreen(
                  temperatureData: this.temperatureList,
                  gasData: this.gasList,
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
  void processData(List<Temperature> tempData, List<Gas> gasData) {
    double maxTemp = 0;
    double maxLength = tempData.length.toDouble();
    temperatureList = [];
    gasList = [];
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

    sum = 0;
    for (int i = 0; i < gasData.length; i++) {
      temp = gasData[i].concentration;
      sum += temp;
      this.gasList.insert(0, temp);
    }
    this.dataProp['avgGas'] = sum / gasData.length;
  }
}
