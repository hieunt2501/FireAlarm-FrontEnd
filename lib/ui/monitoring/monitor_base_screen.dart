import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/textStyle.dart';
import './widgets/time_series_chart.dart';

class MonitorBaseScreen extends StatelessWidget {
// #region Variable declaration
  final List<double> temperatureData; // temperature data list
  final List<double> gasData; // temperature data list
  final List<String> labelData;
  final getTitle; // callback function for setting
  final dataProp; // data properties
// #endregion

  // Constructor
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
        decoration: _buildBoxDecoration(AppColors.normalBackground),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              decoration: _buildBoxDecoration(AppColors.avgBar),
              child: Column(
                children: <Widget>[
                  _buildText("Average", AppTextStyle.avgSyle),
                  const SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 30),
                      _buildText(
                          "Temperature: " + dataProp['avgTemp'].toString(),
                          AppTextStyle.tempAvgStyle),
                      const SizedBox(width: 50),
                    ],
                  ),
                ],
              ),
            ),
            _buidStatusBar(),
            const SizedBox(height: 2),
            TimeChart(
              temperatureData: this.temperatureData,
              gasData: this.gasData,
              labelData: this.labelData,
              getTitle: this.getTitle,
              dataProp: this.dataProp,
            ),
            SizedBox(height: 50),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 100),
          child: Container(
            width: 50,
            height: 5,
            color: Colors.blue[800],
          ),
        ),
        SizedBox(width: 10),
        _buildText("Temperature", AppTextStyle.tempLegend),
      ],
    );
  }

  Widget _buildText(String text, TextStyle style) {
    return Text(
      text,
      style: style,
    );
  }

  Widget _buidStatusBar() {
    return Container(
      height: 20,
      alignment: Alignment.center,
      color: Colors.green[900],
      child: Text(
        'Everything is normal!',
        style: TextStyle(
          color: Colors.grey[350],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(List<Color> colors) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
    );
  }
}
