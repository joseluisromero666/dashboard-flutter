import 'package:argon_flutter/screens/modifyTimeTracking.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class WidgetTreeModifyTimeTracking extends StatefulWidget {
  final index;
  WidgetTreeModifyTimeTracking({this.index});
  @override
  _WidgetTreeModifyTimeTracking createState() => _WidgetTreeModifyTimeTracking();
}

class _WidgetTreeModifyTimeTracking extends State<WidgetTreeModifyTimeTracking> {
  _WidgetTreeModifyTimeTracking();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: ModifyTimeTracking(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: ModifyTimeTracking(),
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
              child: ModifyTimeTracking(),
            )
          ],
        ),
      ),
    );
  }
}
