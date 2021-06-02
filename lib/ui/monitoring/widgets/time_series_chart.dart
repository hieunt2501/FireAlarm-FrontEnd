import 'package:firealarm/models/temperature.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TimeChart extends StatefulWidget {
  final List<double> temperatureData; // temperature data list
  final List<String> labelData; // temperature data list
  final getTitle; // callback function to get chart x label
  final dataProp; //data properties

  TimeChart({
    Key key,
    @required this.temperatureData,
    @required this.labelData,
    @required this.getTitle,
    @required this.dataProp,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TimeChartState();
}

class TimeChartState extends State<TimeChart> {
  double maxTemp;
  double maxLength;
  List<FlSpot> tempSpotList;
  List<FlSpot> gasSpotList;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // aspectRatio: 1.2,
      child: Center(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 420,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                        child: LineChart(
                          lineChartData(),
                          swapAnimationDuration:
                              const Duration(milliseconds: 250),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // SizedBox(
            //   height: 20,
            // ),
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
          rotateAngle: -60,
          showTitles: true,
          // reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          margin: 20,
          getTitles: (value) {
            return widget.getTitle(value);
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
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
      maxX: this.maxLength - 1,
      maxY: this.maxTemp + 20,
      minY: 0,
      lineBarsData: linesBarData(),
    );
  }

  List<LineChartBarData> linesBarData() {
    LineChartBarData temperatureData = LineChartBarData(
      spots: this.tempSpotList,
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
    return [temperatureData];
  }

  void initData() {
    this.maxTemp = widget.dataProp['maxTemp'];
    this.maxLength = widget.dataProp['maxLength'];
    this.tempSpotList = [];
    this.gasSpotList = [];

    int length = widget.temperatureData.length;
    for (int i = 0; i < length; i++) {
      this.tempSpotList.add(FlSpot(i.toDouble(), widget.temperatureData[i]));
    }
  }
}
