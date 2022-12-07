import 'package:argon_flutter/screens/editReport.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class WidgetTreeEditReport extends StatefulWidget {
  final index;
  WidgetTreeEditReport({this.index});
  @override
  _WidgetTreeEditReport createState() => _WidgetTreeEditReport();
}

class _WidgetTreeEditReport extends State<WidgetTreeEditReport> {
  _WidgetTreeEditReport();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: EditReport(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: EditReport(),
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
              child: EditReport(),
            )
          ],
        ),
      ),
    );
  }
}
