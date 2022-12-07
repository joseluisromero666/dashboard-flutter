import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/registerTimeTracking.dart';
import 'package:flutter/material.dart';

class TimeTrackingProvider extends ChangeNotifier {
  Widget timeTrackingCurrentWidget =
      myUserModel.roles[0]["time_tracking"]["time_tracking_create"] ? RegisterTimeTracking() : Text("");

  void set(Widget widget) {
    timeTrackingCurrentWidget = widget;
    notifyListeners();
  }
}
