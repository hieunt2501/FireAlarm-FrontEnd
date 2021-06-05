import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import '../services/device_services.dart';

class HelperFunction{
  static Widget buildSwitch(BuildContext context, bool initState, String deviceID){
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
        } else {
          DeviceAPIs.turnOffDevice(deviceID);
        }
        print('turned ${(state) ? 'yes' : 'no'}');
      },
    );
  }
}
