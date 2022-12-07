import 'package:flutter/material.dart';

class ReportsProvider extends ChangeNotifier {
  Widget reportsCurrentWidget = Text("");
  void set(Widget widget) {
    reportsCurrentWidget = widget;
    notifyListeners();
  }
}
