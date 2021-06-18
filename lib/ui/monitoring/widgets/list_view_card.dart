import 'package:firealarm/constants/const.dart';
import 'package:firealarm/utils/helper_function/helper_function.dart';
import 'package:flutter/material.dart';
import '../../../models/temperature.dart';

class CustomCard extends StatelessWidget {
  final Temperature data;

  CustomCard({
    @required this.data,
  });

  @override
  Widget build(BuildContext context) {
    String date = HelperFunction.extractDate(this.data.time);
    String time = HelperFunction.extractTime(this.data.time);
    String temperature = this.data.temperature.toString();
    return Card(
        child: ListTile(
      title: Text(date + ' - ' + time),
      subtitle: Text("Temperature: " + temperature + ' ' + Const.Celsius),
    ));
  }
}
