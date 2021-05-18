import 'package:flutter/material.dart';
import '../models/time_series_chart.dart';

class MonitorBaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightGreen,
              Colors.lightGreen[100],
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueGrey[900],
                      Colors.blueGrey[800],
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
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
                          width: 60,
                        ),
                        Text(
                          "Temperature: 40",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.brown[50],
                          ),
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        Text(
                          "Gas: 60",
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
              TimeChart(),
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
