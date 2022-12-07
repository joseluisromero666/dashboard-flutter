import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/registerProject.dart';
import 'package:flutter/material.dart';

class ProjectsProvider extends ChangeNotifier {
  Widget projectCurrentWidget = myUserModel.roles[1]["projects"]["projects_create"] ? RegisterProject() : Text("");
  void set(Widget widget) {
    projectCurrentWidget = widget;
    notifyListeners();
  }
}
