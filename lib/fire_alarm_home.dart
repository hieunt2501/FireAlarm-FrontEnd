import 'package:flutter/material.dart';
import './pages/monthly_screen.dart';
import './pages/weekly_screen.dart';
import './pages/daily_screen.dart';
import './pages/hourly_screen.dart';

class FireAlarmAppHome extends StatefulWidget {
  FireAlarmAppHome();

  @override
  _FireAlarmAppHomeState createState() => _FireAlarmAppHomeState();
}

class _FireAlarmAppHomeState extends State<FireAlarmAppHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 4);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          HourlyScreen(),
          DailyScreen(),
          WeeklyScreen(),
          MonthlyScreen(),
        ],
      ),
    );
  }
}
