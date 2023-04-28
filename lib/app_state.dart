import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'navigation/destination.dart';

const isDarkModeKey = "isDarkMode";

class AppState extends ChangeNotifier {
  AppState() {
    _loadPreferences();
  }

  Destination _currentDestination = Destination.home;
  bool _isDarkMode = true;

  Destination get currentDestination => _currentDestination;

  bool get isDarkMode => _isDarkMode;

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(isDarkModeKey) ?? true;
    notifyListeners();
  }

  void navigateTo(Destination destination) {
    _currentDestination = destination;
    notifyListeners();
  }

  Future<void> toggleAppTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(isDarkModeKey, _isDarkMode);
    notifyListeners();
  }
}
