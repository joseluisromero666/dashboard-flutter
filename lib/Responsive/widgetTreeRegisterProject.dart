import 'package:argon_flutter/screens/registerProject.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class WidgetTreeRegisterProject extends StatefulWidget {
  final index;
  WidgetTreeRegisterProject({this.index});
  @override
  _WidgetTreeRegisterProject createState() => _WidgetTreeRegisterProject();
}

class _WidgetTreeRegisterProject extends State<WidgetTreeRegisterProject> {
  _WidgetTreeRegisterProject();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: RegisterProject(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: RegisterProject(),
            )
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: _size.width > 1340 ? 1 : 3,
              child: ArgonDrawer(),
            ),
            Expanded(
              flex: _size.width > 1340 ? 10 : 14,
              child: RegisterProject(),
            )
          ],
        ),
      ),
    );
  }
}
