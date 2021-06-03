import 'package:firealarm/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class DrawerProvider extends ChangeNotifier {
  String _drawerState = '';

  DrawerProvider() {
    _drawerState = Routes.home;
  }

  String get drawerState {
    return _drawerState;
  }

  Future<void> changeDrawer(String route) {
    _drawerState = route;
    notifyListeners();
  }
}
