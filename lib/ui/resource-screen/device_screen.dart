import 'package:flutter/material.dart';
import 'package:firealarm/constants/colors.dart';

class DeviceScreen extends StatefulWidget{
  DeviceScreen({Key key, this.title, this.deviceIdName})
    : super(key: key);
  
  final String title;
  final Map<String,String> deviceIdName;

  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Devices"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      
    );
  }
}