import 'package:flutter/material.dart';
import '../pages/monitor_base_screen.dart';

class DailyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        child: MonitorBaseScreen(),
      ),
    );
  }
}
