// import 'package:firealarm/models/temperature.dart';
import 'package:firealarm/models/temperature.dart';
import 'package:flutter/material.dart';
import '../models/time_series_chart.dart';

class MonitorBaseScreen extends StatelessWidget {
  final List<double> temperatureData; // temperature data list
  final List<double> gasData; // temperature data list
  final List<String> labelData;
  final getTitle; // callback function for setting
  final dataProp; // data properties

  MonitorBaseScreen({
    Key key,
    @required this.temperatureData,
    @required this.gasData,
    @required this.labelData,
    @required this.getTitle,
    @required this.dataProp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightGreen[400],
              Colors.lightGreen[100],
              Colors.lightGreen[400],
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              // Average box
              Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueGrey[900],
                      Colors.blueGrey[800],
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                // Average child
                child: Column(
                  children: <Widget>[
                    Text(
                      "Average",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.brown[50],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Temperature: " + dataProp['avgTemp'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.brown[50],
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          "Gas: " + dataProp['avgGas'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.brown[50],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                alignment: Alignment.center,
                // decoration: BoxDecoration(),
                color: Colors.green[900],
                child: Text(
                  'Everything is normal!',
                  style: TextStyle(
                    color: Colors.grey[350],
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              TimeChart(
                temperatureData: this.temperatureData,
                gasData: this.gasData,
                labelData: this.labelData,
                getTitle: this.getTitle,
                dataProp: this.dataProp,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Container(
                        width: 50,
                        height: 5,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Temperature',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Container(
                        width: 50,
                        height: 5,
                        color: Color(0xffaa4cfc),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Gas concentration',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
