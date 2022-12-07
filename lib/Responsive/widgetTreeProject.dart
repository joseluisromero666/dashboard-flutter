import 'package:argon_flutter/screens/specificProject.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class WidgetTreeProject extends StatefulWidget {
  final index;
  WidgetTreeProject({this.index});
  @override
  _WidgetTreeProject createState() => _WidgetTreeProject();
}

class _WidgetTreeProject extends State<WidgetTreeProject> {
  _WidgetTreeProject();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: SpecificProject(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: SpecificProject(),
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
              child: SpecificProject(),
            )
          ],
        ),
      ),
    );
  }
}
