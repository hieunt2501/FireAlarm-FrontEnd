import 'package:flutter/material.dart';

import '../../services/device_services.dart';
import '../../utils/helper_function/helper_function.dart';

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
  void initState(){
    super.initState();
  }

  List<Widget> buildListTile(){
    Widget buildSwitchListTile(String deviceName, String deviceId){
      return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(deviceName, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
            FutureBuilder<bool>(
              future: DeviceAPIs.checkDevice(deviceId),
              builder: (BuildContext context,
                  AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return HelperFunction.buildSwitch(
                      context, snapshot.data, deviceId);
                }
                return CircularProgressIndicator();
              }
            )
          ],
        ),
      );
    }

    List<Widget> listTile = [];
    if (widget.deviceIdName != null){
      widget.deviceIdName.forEach((key, value) {
        listTile.add(buildSwitchListTile(value, key));
      });
    }
    else {
      listTile.add(
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Text("This room does not have any devices!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),)),
        );
    }
    return listTile;
  }

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildListTile(),  
        ),
      )
      
    );
  }
}