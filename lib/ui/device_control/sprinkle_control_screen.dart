import 'package:flutter/material.dart';

class WaterSprinkleControllerScreen extends StatefulWidget {
  WaterSprinkleControllerScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WaterSprinkleControllerScreenState createState() => _WaterSprinkleControllerScreenState();
}

class _WaterSprinkleControllerScreenState extends State<WaterSprinkleControllerScreen> {

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
                        'Sprinkle System Controller',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color.fromRGBO(7, 121, 137, 1),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w200,
                          fontSize: 30,
                        )
                      )
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
