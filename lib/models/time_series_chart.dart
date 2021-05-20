import 'package:firealarm/models/temperature.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TimeChart extends StatefulWidget {
  final List<double> temperatureData; // temperature data list
  final List<double> gasData; // temperature data list
  final List<String> labelData; // temperature data list
  final getTitle; // callback function to get chart x label
  final dataProp; //data properties

  TimeChart({
    Key key,
    @required this.temperatureData,
    @required this.gasData,
    @required this.labelData,
    @required this.getTitle,
    @required this.dataProp,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TimeChartState();
}

class TimeChartState extends State<TimeChart> {
  bool tempPressed;
  bool gasPressed;
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
                      height: 350,
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
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(left: 50),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: Text("Temp"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(80, 40),
                        primary:
                            this.tempPressed ? Colors.transparent : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          this.tempPressed = !this.tempPressed;
                        });
                      },
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(left: 85),
                    child: ElevatedButton(
                      child: Text("Gas"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(80, 40),
                        primary:
                            this.gasPressed ? Colors.transparent : Colors.grey,
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
    LineChartBarData gasData = LineChartBarData(
      spots: this.gasSpotList,
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
    LineChartBarData emptyData = LineChartBarData(
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
      result.add(temperatureData);
    }
    if (this.gasPressed) {
      result.add(gasData);
    } else
      result.add(emptyData);
    return result;
  }

  void initData() {
    this.tempPressed = true;
    this.gasPressed = true;
    this.maxTemp = widget.dataProp['maxTemp'];
    this.maxLength = widget.dataProp['maxLength'];
    this.tempSpotList = [];
    this.gasSpotList = [];

    int length = widget.temperatureData.length;
    for (int i = 0; i < length; i++) {
      this.tempSpotList.add(FlSpot(i.toDouble(), widget.temperatureData[i]));
    }

    length = widget.gasData.length;
    for (int i = 0; i < length; i++) {
      this.gasSpotList.add(FlSpot(i.toDouble(), widget.gasData[i]));
    }
  }
}
