import 'package:flutter/material.dart';

import '../../services/device_services.dart';
import '../../utils/helper_function/helper_function.dart';

import '../../icon/bell-slash-icon.dart';

class SmokeDetectionScreen extends StatefulWidget {
  SmokeDetectionScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SmokeDetectionScreenState createState() => _SmokeDetectionScreenState();
}

class _SmokeDetectionScreenState extends State<SmokeDetectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
            ),
            child: FractionallySizedBox(
              widthFactor: 0.8,
              heightFactor: 0.9,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Text(
                      'Smoke detected!',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color(0xff7c94b6),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w200,
                        fontSize: 50,
                      ),
                      textAlign: TextAlign.center,
                    )),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Is this a false alarm?",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RawMaterialButton(
                          fillColor: Color.fromRGBO(9, 197, 5, 1),
                          onPressed: () {DeviceAPIs.turnOffDevice("3");},
                          shape: CircleBorder(),
                          child: Icon(
                            BellSlash.bell_slash,
                            size: 20,
                          ),
                          padding: EdgeInsets.only(
                              left: 8, top: 20, right: 12, bottom: 20),
                        ),
                      ],
                    )),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Control the fan',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15),
                          FutureBuilder<bool>(
                            future: DeviceAPIs.checkDevice("10"),
                            builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                  return  CircularProgressIndicator();
                              }
                              else{
                                  if (snapshot.hasError){
                                    print(snapshot.error);
                                    return  CircularProgressIndicator();
                                    }
                                  else
                                    return HelperFunction.buildSwitch(context, snapshot.data, "10");
                              }
                              // if(snapshot.connectionState == ConnectionState.done){
                              //   return HelperFunction.buildSwitch(context, snapshot.data, "10");
                              // }
                              // return CircularProgressIndicator();
                            }
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    ));
  }
}
