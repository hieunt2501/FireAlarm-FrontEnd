import 'package:firealarm/providers/drawer_provider.dart';
import 'package:firealarm/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import '../fire_detection/fire_detected_screen.dart';
import '../smoke_detection/smoke_detected_screen.dart';
import '../monitoring/daily_screen.dart';
import '../monitoring/real_time_screen.dart';
import '../monitoring/hourly_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firealarm/caches/sharedpref/shared_preference_helper.dart';

import '../../utils/helper_function/helper_function.dart';

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
  String currentPage;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message.notification.title == 'Fire detected!') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FireDetectionScreen(
                    temperature: HelperFunction.extractTemperature(
                        message.notification.body))));
      }
      if (message.notification.title == 'Smoke detected!') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SmokeDetectionScreen()));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification.title == 'Fire detected!') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FireDetectionScreen(
                    temperature: HelperFunction.extractTemperature(
                        message.notification.body))));
      }
      if (message.notification.title == 'Smoke detected!') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SmokeDetectionScreen()));
      }
    });

    _onMessage();
    _initTabController();
    currentPage = Routes.home;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return;
        },
        child: Scaffold(
          appBar: _buildAppBar(),
          drawer: _buildDrawer(),
          body: _buildBody(),
        ));
  }

// #region Drawer methods
  Widget _buildDrawer() {
    // String drawerState = "";
    return Consumer<DrawerProvider>(
      builder: (_, drawerProviderPref, __) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: Text('Monitoring'),
                tileColor: drawerProviderPref.drawerState == Routes.home
                    ? Colors.grey
                    : Colors.white,
                // currentPage == Routes.home ? Colors.grey : Colors.white,
                onTap: () {
                  if (drawerProviderPref.drawerState != Routes.home) {
                    drawerProviderPref.changeDrawer(Routes.home);
                    Navigator.pushNamed(context, Routes.home);
                  }
                },
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  if (drawerProviderPref.drawerState != Routes.profile) {
                    drawerProviderPref.changeDrawer(Routes.profile);
                    Navigator.pushNamed(context, Routes.profile);
                    drawerProviderPref.changeDrawer(Routes.home);
                  }
                },
              ),
              ListTile(
                title: Text('Resource'),
                onTap: () {
                  if (drawerProviderPref.drawerState != Routes.resource)
                    drawerProviderPref.changeDrawer(Routes.resource);
                  Navigator.pushNamed(context, Routes.resource);
                },
              )
            ],
          ),
        );
      },
    );
  }
// #endregion

// #region App bar methods
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text("Monitoring"),
      elevation: 0.7,
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        tabs: <Widget>[
          Tab(text: "Real-Time"),
          Tab(text: "Hourly"),
          Tab(text: "Daily"),
        ],
      ),
    );
  }
// #endregion

// #region Body methods
  Widget _buildBody() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        RealTimeScreen(),
        HourlyScreen(),
        DailyScreen(),
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FireDetectionScreen(
                    temperature: HelperFunction.extractTemperature(
                        message.notification.body))));
      }

      if (message.notification.title == "Smoke detected!") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SmokeDetectionScreen()));
      }
    });
  }

  // initializing tab controller
  _initTabController() {
    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);
    _tabController.addListener(() {
      setState(() {});
    });
  }
// #endregion
}
