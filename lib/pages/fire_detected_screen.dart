import 'package:flutter/material.dart';
import '../icon/bell-slash-icon.dart' ;
import '../icon/temperature-icon.dart';
import '../icon/smoke-icon.dart' ;
import '../icon/phone-icon.dart' ;
import '../icon/water-icon.dart' ;

class FireDetectionScreen extends StatefulWidget {
  FireDetectionScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FireDetectionScreenState createState() => _FireDetectionScreenState();
}

class _FireDetectionScreenState extends State<FireDetectionScreen> {
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
                        'Fire detected!',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color.fromRGBO(255, 15, 0, 1),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w200,
                          fontSize: 50,
                        )
                      )
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Temperature.temperature_high),
                                onPressed: () {},
                              ),
                              Text(
                                '100 Celcius',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Color.fromRGBO(0,0,0,1),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                )
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Smoke.smoke),
                                onPressed: () {},
                              ),
                              Text(
                                '100 ppm',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Color.fromRGBO(0,0,0,1),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                )
                              ),
                            ]
                          )
                        ],
                      ),
                    ),
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
                          SizedBox(height: 10,),
                          RawMaterialButton(
                            fillColor: Color.fromRGBO(9,197,5,1),
                            onPressed: () {},
                            shape: CircleBorder(),
                            child: Icon(
                              BellSlash.bell_slash,
                              size: 20,
                            ),
                            padding: EdgeInsets.only(left:8, top:20, right:12, bottom:20),
                          ),
                        ],
                      )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Within 15 minutes, if you don’t respond to the alarm, we will automatically activate the sprinkle system.',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RawMaterialButton(
                            fillColor: Color.fromRGBO(240,131,4,1),
                            onPressed: () {},
                            shape: CircleBorder(),
                            child: Icon(
                              Phone.phone,
                              size: 30,
                            ),
                            padding: EdgeInsets.all(30.0),
                          ),
                          RawMaterialButton(
                            fillColor: Color.fromRGBO(240,131,4,1),
                            onPressed: () {},
                            shape: CircleBorder(),
                            child: Icon(
                              Water.water,
                              size: 30,
                            ),
                            padding: EdgeInsets.all(30.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
        ),
      )
    );
  }
}