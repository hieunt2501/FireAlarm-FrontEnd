import 'package:flutter/material.dart';
import 'icon/bell-slash-icon.dart' ;
import 'icon/smoke-icon.dart' ;
import 'icon/temperature-icon.dart' ;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.getToken().then((value){
        print('#####################################################');
        print(value);
    });
  print('aaaaa');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print('bbbbb');
  FirebaseMessaging.onMessage.listen((RemoteMessage message){
    print('#####################################################');
    print('A message just showed up :  ${message.data}');
    print('#####################################################');
    print('smoke: ${message.data['smoke']}');
    print('fire: ${message.data['fire']}');
  });
  print('ccccc');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FireDetectionScreen(title: 'Flutter Demo Home Page'),
      // home: WaterSprinkleControllerScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class FireDetectionScreen extends StatefulWidget {
  FireDetectionScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FireDetectionScreenState createState() => _FireDetectionScreenState();
}

class WaterSprinkleControllerScreen extends StatefulWidget {
  WaterSprinkleControllerScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WaterSprinkleControllerScreenState createState() => _WaterSprinkleControllerScreenState();
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
                              Icons.volume_up,
                              size: 30,
                            ),
                            padding: EdgeInsets.all(30.0),
                          ),
                          RawMaterialButton(
                            fillColor: Color.fromRGBO(240,131,4,1),
                            onPressed: () {},
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.volume_up,
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
