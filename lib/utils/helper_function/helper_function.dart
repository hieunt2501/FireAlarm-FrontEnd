import 'package:flutter/material.dart';
// import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import '../custom_widget/custom_switch.dart';
import '../../services/device_services.dart';
import 'dart:math';

class HelperFunction {
  static Widget buildSwitch(
      BuildContext context, bool initState, String deviceID) {
    return LiteRollingSwitch(
      value: initState,
      textOn: 'On',
      textOff: 'Off',
      colorOn: Colors.cyan,
      colorOff: Colors.red[400],
      iconOn: Icons.check,
      iconOff: Icons.power_settings_new,
      animationDuration: Duration(milliseconds: 500),
      onChanged: (bool state) {
        if (state) {
          DeviceAPIs.turnOnDevice(deviceID);
          print('turned on!');
        } else {
          DeviceAPIs.turnOffDevice(deviceID);
          print('turned off!');
        }
      },
    );
  }

  static String extractTemperature(String messBody) {
    return messBody.split(' ')[3];
  }

  static double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static String extractDate(DateTime time) {
    String day = time.day.toString();
    String month = time.month.toString();
    String year = time.year.toString();
    // String time = time.
    return day + '/' + month + '/' + year;
  }

  static String extractTime(DateTime time) {
    String hour = time.hour.toString();
    String minute = time.minute.toString();
    String second = time.second.toString();

    return hour + ':' + minute + ':' + second;
  }
}
