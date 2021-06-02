import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../constants/api.dart';

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
                        child: Text('Smoke detected!',
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
                          onPressed: () {},
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
                          LiteRollingSwitch(
                            value: false,
                            textOn: 'On',
                            textOff: 'Off',
                            colorOn: Colors.cyan,
                            colorOff: Colors.red[400],
                            iconOn: Icons.check,
                            iconOff: Icons.power_settings_new,
                            animationDuration: Duration(milliseconds: 500),
                            onChanged: (bool state) {
                              // if (state) {
                              //   APIS().turnOnDevice("14");
                              // } else {
                              //   APIS().turnOffDevice("14");
                              // }
                              print('turned ${(state) ? 'yes' : 'no'}');
                            },
                          ),
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
