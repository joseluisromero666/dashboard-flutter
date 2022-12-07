import 'package:argon_flutter/screens/report.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'responsiveController.dart';

class WidgetTreeReport extends StatefulWidget {
  final index;
  WidgetTreeReport({this.index});
  @override
  _WidgetTreeReport createState() => _WidgetTreeReport();
}

class _WidgetTreeReport extends State<WidgetTreeReport> {
  _WidgetTreeReport();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: ResponsiveLayout(
        phone: Report(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: Report(),
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
              child: Report(),
            )
          ],
        ),
      ),
    );
  }
}
