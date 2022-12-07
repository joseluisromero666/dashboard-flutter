import 'package:argon_flutter/models/userModel.dart';
import 'package:argon_flutter/screens/RegisterContracts.dart';
import 'package:flutter/material.dart';

class ContractsProvider extends ChangeNotifier {
  Widget contractCurrentWidget = myUserModel.roles[2]["contracts"]["contracts_create"] ? RegisterContracts() : Text("");
  void set(Widget widget) {
    contractCurrentWidget = widget;
    notifyListeners();
  }
}
