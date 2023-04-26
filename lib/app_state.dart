import 'package:flutter/foundation.dart';

import 'navigation/destination.dart';

class AppState extends ChangeNotifier {
  Destination currentDestination = Destination.home;

  void navigateTo(Destination destination) {
    currentDestination = destination;
    notifyListeners();
  }
}
