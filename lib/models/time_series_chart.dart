import 'package:firealarm/models/temperature.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TimeChart extends StatefulWidget {
  final List<Temperature> temperatureData;

  TimeChart({Key key, @required this.temperatureData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TimeChartState();
}

class TimeChartState extends State<TimeChart> {
  // List<int> verticalAxis;
  bool tempPressed;
  bool gasPressed;
  double maxTemp;
  double maxLength;
  List<FlSpot> spotList;

  @override
  void initState() {
    super.initState();
    initData();
    // this.spotList = makeSpotList();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    child: LineChart(
                      lineChartData(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 80, top: 30, bottom: 20),
                        child: ElevatedButton(
                          child: Text("Temp"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(80, 40),
                            primary: this.tempPressed
                                ? Colors.transparent
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              this.tempPressed = !this.tempPressed;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 85, top: 30, bottom: 20),
                        child: ElevatedButton(
                          child: Text("Gas"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(80, 40),
                            primary: this.gasPressed
                                ? Colors.transparent
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              this.gasPressed = !this.gasPressed;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData lineChartData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        drawVerticalLine: true,
        verticalInterval: 1,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            return getTitle(value);
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
          // getTextStyles: (value) => const TextStyle(
          //   color: Color(0xff75729e),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 14,
          // ),
          // getTitles: (value) {
          //   switch (value.toInt()) {
          //     case 1:
          //       return '1m';
          //     case 2:
          //       return '2m';
          //     case 3:
          //       return '3m';
          //     case 4:
          //       return '5m';
          //   }
          //   return '';
          // },
          // margin: 0.2,
          // reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: this.maxLength,
      maxY: this.maxTemp + 20,
      minY: 0,
      lineBarsData: linesBarData(),
    );
  }

  List<LineChartBarData> linesBarData() {
    LineChartBarData lineChartBarData1 = LineChartBarData(
      // spots: this.spotList,
      spots: [
        FlSpot(1, 35),
        FlSpot(2, 35),
        FlSpot(3, 35),
      ],
      isCurved: true,
      colors: [
        Colors.blue[800],
      ],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        // FlSpot(1, 35),
        // FlSpot(3, 34.4),
        // FlSpot(7, 37),
        // FlSpot(10, 37.5),
        // FlSpot(12, 38),
        // FlSpot(13, 37),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );

    List<LineChartBarData> result = [];
    if (this.tempPressed) {
      result.add(lineChartBarData1);
    }
    if (this.gasPressed) {
      result.add(lineChartBarData2);
    } else
      result.add(lineChartBarData3);
    return result;
  }

  void initData() {
    this.tempPressed = true;
    this.gasPressed = true;
    this.maxTemp = 0;
    this.spotList = [];
    this.maxLength = widget.temperatureData.length.toDouble();

    var temp;
    for (int i = 0; i < widget.temperatureData.length; i++) {
      temp = widget.temperatureData[i].temperature;
      this.spotList.add(FlSpot(i.toDouble(), temp));
      if (this.maxTemp < temp) this.maxTemp = temp;
      print(widget.temperatureData[i].time);
    }
  }

  String getTitle(double value) {
    return (widget.temperatureData[value.toInt()].time.hour).toString() + 'h';
  }
}
