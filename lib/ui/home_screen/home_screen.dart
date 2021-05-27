import 'package:flutter/material.dart';
import '../fire_detection/fire_detected_screen.dart';
import '../monitoring/daily_screen.dart';
import '../monitoring/real_time_screen.dart';
import '../monitoring/weekly_screen.dart';
import '../monitoring/monthly_screen.dart';

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

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _onMessage();
    _initTabController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

// #region App bar methods
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text("Monitoring"),
      elevation: 0.7,
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        tabs: <Widget>[
          Tab(text: "Hourly"),
          Tab(text: "Daily"),
          Tab(text: "Weekly"),
          Tab(text: "Monthly"),
        ],
      ),
      actions: <Widget>[
        // Icon(Icons.search),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
        ),
        Icon(Icons.more_vert)
      ],
    );
  }
// #endregion

// #region Body methods
  Widget _buildBody() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        RealTimeScreen(),
        DailyScreen(),
        WeeklyScreen(),
        MonthlyScreen(),
      ],
    );
  }
// #endregion

// #region General methods
  // On receiving Firebase message
  _onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('#####################################################');
      // print('A message just showed up :  ${message.data}');
      // print(message.notification.title);
      // print(message.notification.body);
      // print('#####################################################');

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }

      if (message.notification.title == "Fire detected!") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FireDetectionScreen()));
      }
    });
  }

  // initializing tab controller
  _initTabController() {
    _tabController = TabController(vsync: this, initialIndex: 0, length: 4);
    _tabController.addListener(() {
      setState(() {});
    });
  }
// #endregion
}
